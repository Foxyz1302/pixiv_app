import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixiv_app/detail_page.dart';
import 'package:pixiv_app/detail_screen.dart';
import 'package:pixiv_app/traversal_guard.dart';
import 'package:pixiv_app/ugoira_player.dart';
import 'package:pixiv_app/web/pixiv_web_models.dart';

WebDiscoveryIllust _illust(String id, {int pageCount = 0, int illustType = 0}) {
  return WebDiscoveryIllust(id, 'post $id',
      pageCount: pageCount,
      illustType: illustType,
      profileImageUrl: 'https://example.invalid/$id.jpg');
}

Finder _detailPage(String id) => find.byWidgetPredicate(
      (w) => w is DetailPage && w.illust.id == id,
      skipOffstage: false,
    );

void main() {
  testWidgets('multi-image post pages through placeholders while loading', (tester) async {
    TraversalGuard.enter();
    addTearDown(TraversalGuard.exit);
    await tester.pumpWidget(MaterialApp(home: DetailScreen(items: [_illust('m', pageCount: 3)])));
    await tester.pump();
    expect(find.text('1 / 3'), findsOneWidget);
    // Start on the artwork, like a thumb would: the badge is a Stack
    // overlay beside the pager and never hands a drag to it.
    await tester.dragFrom(const Offset(400, 300), const Offset(-600, 0));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('2 / 3'), findsOneWidget);
    expect(_detailPage('m'), findsOneWidget);
  });

  testWidgets('ugoira player mounts before detail arrives', (tester) async {
    TraversalGuard.enter();
    addTearDown(TraversalGuard.exit);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DetailPage(illust: _illust('u', illustType: 2))),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(UgoiraPlayer), findsOneWidget);
  });

  testWidgets('outer pager releases keepalive past the preload window', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DetailScreen(items: [_illust('0'), _illust('1'), _illust('2'), _illust('3'), _illust('4')])),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(_detailPage('0'), findsOneWidget);
    await tester.flingFrom(const Offset(600, 300), const Offset(-500, 0), 900);
    await tester.pumpAndSettle();
    expect(_detailPage('0'), findsOneWidget);
    expect(_detailPage('1'), findsOneWidget);
    await tester.flingFrom(const Offset(600, 300), const Offset(-500, 0), 900);
    await tester.pumpAndSettle();
    expect(_detailPage('0'), findsNothing);
    expect(_detailPage('1'), findsOneWidget);
    expect(_detailPage('2'), findsOneWidget);
  });
}
