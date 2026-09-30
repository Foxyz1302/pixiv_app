import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixiv_app/detail_page.dart';
import 'package:pixiv_app/web/pixiv_web_models.dart';

Future<void> _pumpFailureViewer(WidgetTester tester, Size surface) async {
  tester.view.physicalSize = surface;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DetailPage(
          illust: WebDiscoveryIllust('1', 'cap test',
              profileImageUrl: 'https://example.invalid/a.jpg'),
          viewerMaxHeight: 700,
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  testWidgets('failure viewer fits pager box on widescreen', (tester) async {
    await _pumpFailureViewer(tester, const Size(1600, 900));
    expect(find.text('Retry'), findsWidgets);
    expect(
      find.byWidgetPredicate((w) => w is SizedBox && w.height == 700),
      findsOneWidget,
    );
    expect(find.byType(AspectRatio), findsNothing);
  });

  testWidgets('failure viewer fits pager box on portrait window', (tester) async {
    await _pumpFailureViewer(tester, const Size(900, 1600));
    expect(find.text('Retry'), findsWidgets);
    expect(
      find.byWidgetPredicate((w) => w is SizedBox && w.height == 700),
      findsOneWidget,
    );
    expect(find.byType(AspectRatio), findsNothing);
  });
}
