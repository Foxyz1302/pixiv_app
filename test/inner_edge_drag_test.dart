import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixiv_app/detail_page.dart';
import 'package:pixiv_app/detail_screen.dart';

/// Harness mirroring production's nested-pager handoff (DetailScreen):
/// inner-edge overscroll drives the outer position through a real held-drag
/// activity; release ends it with the finger velocity so the framework's own
/// page-snapping settles.
class _Harness {
  _Harness(this.tester)
      : outerController = PageController(initialPage: 1),
        innerController = PageController(initialPage: 2);

  final WidgetTester tester;
  final PageController outerController;
  final PageController innerController;
  Drag? outerHold;
  bool dragging = false;
  int startPage = 1;

  Future<void> pump() async {
    final outer = outerController;
    final inner = innerController;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PageView.builder(
            physics: const SnappyPagePhysics(),
            controller: outer,
            itemCount: 3,
            itemBuilder: (context, outerIndex) {
              if (outerIndex != 1) {
                return Container(
                  color: Colors.grey,
                  child: Center(child: Text('outer $outerIndex')),
                );
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  if (n is ScrollStartNotification) {
                    dragging = true;
                    startPage = outer.hasClients
                        ? (outer.page?.round() ?? 1)
                        : 1;
                    outerHold?.cancel();
                    if (outer.hasClients) {
                      outerHold = outer.position.drag(DragStartDetails(), () {});
                    }
                  } else if (n is OverscrollNotification && n.dragDetails != null) {
                    final hold = outerHold;
                    if (hold != null && outer.hasClients && n.overscroll != 0) {
                      hold.update(
                        DragUpdateDetails(
                          globalPosition: Offset.zero,
                          delta: Offset(-n.overscroll, 0),
                          primaryDelta: -n.overscroll,
                        ),
                      );
                    }
                  } else if (n is ScrollEndNotification) {
                    if (dragging) {
                      dragging = false;
                      final hold = outerHold;
                      outerHold = null;
                      if (hold != null && outer.hasClients) {
                        final pos = outer.position;
                        final endVelocity = resolveEndVelocity(
                          pixels: pos.pixels,
                          pageOrigin: startPage * pos.viewportDimension,
                          viewport: pos.viewportDimension,
                          fingerVelocity:
                              n.dragDetails?.primaryVelocity ?? 0,
                        );
                        hold.end(
                          DragEndDetails(
                            primaryVelocity: endVelocity,
                            velocity: Velocity(
                              pixelsPerSecond: Offset(endVelocity, 0),
                            ),
                          ),
                        );
                      }
                    }
                  }
                  return false;
                },
                child: PageView.builder(
                  physics: const SnappyPagePhysics(),
                  controller: inner,
                  itemCount: 3,
                  itemBuilder: (context, i) => Container(
                    color: i == 2 ? Colors.red : Colors.blue,
                    child: Center(child: Text('inner $i')),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  double get outerPixels => outerController.position.pixels;
}

void main() {
  testWidgets('edge push follows 1:1 with no mid-drag snap-back', (tester) async {
    final h = _Harness(tester);
    await h.pump();
    expect(h.outerController.page, 1.0);

    final gesture = await tester.startGesture(tester.getCenter(find.text('inner 2')));
    final offsets = <double>[];
    for (var i = 0; i < 10; i++) {
      await gesture.moveBy(const Offset(-20, 0));
      await tester.pump(const Duration(milliseconds: 16));
      offsets.add(h.outerPixels);
    }
    debugPrint('offsets: $offsets');
    for (var i = 1; i < offsets.length; i++) {
      expect(offsets[i] >= offsets[i - 1] - 0.5, isTrue,
          reason: 'outer fought back at step $i: $offsets');
    }
    await gesture.up();
    await tester.pumpAndSettle();
    expect(h.outerController.page, 2.0);
  });

  testWidgets('holding mid-drag holds outer offset (jumpTo-spring regression)', (tester) async {
    final h = _Harness(tester);
    await h.pump();

    final gesture = await tester.startGesture(tester.getCenter(find.text('inner 2')));
    for (var i = 0; i < 5; i++) {
      await gesture.moveBy(const Offset(-20, 0));
      await tester.pump(const Duration(milliseconds: 16));
    }
    final heldAt = h.outerPixels;
    expect(heldAt, greaterThan(800.0));
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      expect((h.outerPixels - heldAt).abs() < 1.0, isTrue,
          reason: 'outer drifted during hold: $heldAt -> ${h.outerPixels}');
    }
    await gesture.up();
    await tester.pumpAndSettle();
  });

  testWidgets('long push crosses page boundary and framework settle commits', (tester) async {
    final h = _Harness(tester);
    await h.pump();

    final gesture = await tester.startGesture(tester.getCenter(find.text('inner 2')));
    final offsets = <double>[];
    for (var i = 0; i < 35; i++) {
      await gesture.moveBy(const Offset(-20, 0));
      await tester.pump(const Duration(milliseconds: 16));
      offsets.add(h.outerPixels);
    }
    debugPrint('long-drag offsets: $offsets');
    for (var i = 1; i < offsets.length; i++) {
      expect(offsets[i] >= offsets[i - 1] - 0.5, isTrue,
          reason: 'outer fought back at step $i: $offsets');
    }
    await gesture.up();
    await tester.pumpAndSettle();
    expect(h.outerController.page, 2.0);
  });

  testWidgets('stopped release past threshold commits (origin pinned at drag start)', (tester) async {
    final h = _Harness(tester);
    await h.pump();

    final gesture = await tester.startGesture(tester.getCenter(find.text('inner 2')));
    for (var i = 0; i < 30; i++) {
      await gesture.moveBy(const Offset(-20, 0));
      await tester.pump(const Duration(milliseconds: 100));
    }
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(h.outerPixels, greaterThan(800.0 + 800.0 * 0.12),
        reason: 'setup: outer must sit past the 0.12 commit threshold before release, got ${h.outerPixels}');
    await gesture.up();
    await tester.pumpAndSettle();
    expect(h.outerController.page, 2.0,
        reason: 'fully-stopped release past threshold must commit, not snap back');
  });

  testWidgets('trembling push advances net-forward without snap-back', (tester) async {
    final h = _Harness(tester);
    await h.pump();

    final gesture = await tester.startGesture(tester.getCenter(find.text('inner 2')));
    final offsets = <double>[];
    final steps = [for (var i = 0; i < 12; i++) ...[const Offset(-20, 0), const Offset(7, 0)]];
    for (final step in steps) {
      await gesture.moveBy(step);
      await tester.pump(const Duration(milliseconds: 16));
      offsets.add(h.outerPixels);
    }
    debugPrint('tremor offsets: $offsets');
    expect(offsets.last, greaterThan(offsets.first + 50));
    var worstDrop = 0.0;
    for (var i = 1; i < offsets.length; i++) {
      final drop = offsets[i - 1] - offsets[i];
      if (drop > worstDrop) worstDrop = drop;
    }
    expect(worstDrop, lessThan(30), reason: 'snap-back mid-drag: $offsets');
    await gesture.up();
    await tester.pumpAndSettle();
  });

  test('resolveEndVelocity commits past threshold, passes through below', () {
    expect(
      resolveEndVelocity(pixels: 1000, pageOrigin: 800, viewport: 800, fingerVelocity: 0),
      -1600,
    );
    expect(
      resolveEndVelocity(pixels: 600, pageOrigin: 800, viewport: 800, fingerVelocity: 0),
      1600,
    );
    expect(
      resolveEndVelocity(pixels: 850, pageOrigin: 800, viewport: 800, fingerVelocity: -200),
      -200,
    );
    expect(
      resolveEndVelocity(pixels: 800, pageOrigin: 800, viewport: 0, fingerVelocity: 300),
      300,
    );
  });

/// Framework-behavior probes for mid-animation grabs (no production code).
/// Outer 3 pages, inner 4 pages starting at index 1.
Future<({PageController outer, PageController inner})> _pumpNestedGrabHarness(
  WidgetTester tester,
) async {
  final outer = PageController(initialPage: 1);
  final inner = PageController(initialPage: 1);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: PageView.builder(
          physics: const SnappyPagePhysics(),
          controller: outer,
          itemCount: 3,
          itemBuilder: (context, oi) => oi == 1
              ? PageView.builder(
                  physics: const SnappyPagePhysics(),
                  controller: inner,
                  itemCount: 4,
                  itemBuilder: (context, ii) => Container(
                    color: Colors.primaries[ii],
                    child: Center(child: Text('inner $ii')),
                  ),
                )
              : Container(color: Colors.grey, child: Center(child: Text('outer $oi'))),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (outer: outer, inner: inner);
}

  testWidgets('framework: ballistic inner snap stays grabbable, outer static', (tester) async {
    final c = await _pumpNestedGrabHarness(tester);
    await tester.fling(find.text('inner 1'), const Offset(-400, 0), 2000);
    await tester.pump(const Duration(milliseconds: 100));
    final gesture = await tester.startGesture(const Offset(400, 300));
    for (var i = 0; i < 8; i++) {
      await gesture.moveBy(const Offset(-25, 0));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();
    expect(c.outer.page, 1.0, reason: 'outer must not steal a ballistic inner grab');
    expect(c.inner.page, greaterThanOrEqualTo(2.0), reason: 'inner must keep responding');
  });

  testWidgets('framework: mid-driven grab reaches inner (contradicts source reading)', (tester) async {
    // Open investigation, see roadmap research queue ("Inner mid-animation
    // grab"). DrivenScrollActivity.shouldIgnorePointer is true in source,
    // yet this probe shows a mid-driven grab tracking on inner with outer
    // static — plus the driven animation never visibly progressing. Either
    // the ignore isn't applied on this path or the harness misses a
    // device-only ingredient. If this test starts failing, the framework
    // behavior changed — re-read the roadmap entry before touching pager code.
    final c = await _pumpNestedGrabHarness(tester);
    unawaited(c.inner.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeOut));
    await tester.pump(const Duration(milliseconds: 100));
    final gesture = await tester.startGesture(const Offset(400, 300));
    final outerOffsets = <double>[];
    final innerOffsets = <double>[];
    for (var i = 0; i < 8; i++) {
      await gesture.moveBy(const Offset(-25, 0));
      await tester.pump(const Duration(milliseconds: 16));
      outerOffsets.add(c.outer.position.pixels);
      innerOffsets.add(c.inner.position.pixels);
    }
    await gesture.up();
    await tester.pumpAndSettle();
    debugPrint('driven-grab outer: $outerOffsets inner: $innerOffsets');
    for (final o in outerOffsets) {
      expect(o, 800.0, reason: 'outer must stay put: $outerOffsets');
    }
    expect(innerOffsets.last, greaterThan(innerOffsets.first + 100));
  });
}
