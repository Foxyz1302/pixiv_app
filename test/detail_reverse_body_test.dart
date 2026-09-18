import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixiv_app/detail_screen.dart';
import 'package:pixiv_app/web/pixiv_web_models.dart';
import 'package:pixiv_app/web_session.dart';

// Dio (used by PxImageProvider) honors HttpOverrides: fail every request
// immediately so no test ever waits on real network timeouts.
class _FailFastOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    throw const SocketException('test: no network');
  }
}

void main() {
  setUp(() {
    HttpOverrides.global = _FailFastOverrides();
    WebSession.instance.reverseDetails.value = true;
  });
  tearDown(() {
    HttpOverrides.global = null;
    WebSession.instance.reverseDetails.value = false;
  });

  testWidgets('reverse detail body lays out title + sections', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetailScreen(
          // Non-empty avatar: ArtistAvatar asserts on (null image +
          // non-null error handler), and the handler swallows the
          // fail-fast load error. Empty url would throw every build.
          items: [
            WebDiscoveryIllust('1', 'Hello thumb world',
                profileImageUrl: 'https://example.invalid/a.jpg')
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    // The failure UI (viewer error + related error) sits in the visible
    // window with no scrolling needed in either mode. If the body lays
    // out, its Retry buttons are in the tree; a void body shows none.
    expect(find.text('Retry'), findsWidgets);

    // Slivers only build visible + cached children, so the info title
    // starts unbuilt behind the tall viewer. In a reversed list, scrolling
    // toward the top content is finger-down: nudge +400 (no settle, so the
    // offset holds) to bring the title into the window, then assert both
    // copies: bottom-bar subtitle + info title.
    await tester.drag(find.byType(ListView), const Offset(0, 400));
    await tester.pump();

    // 'Hello thumb world' appears twice when healthy: bottom-bar
    // subtitle + info title inside the body list. A void body shows only
    // the bar copy.
    expect(find.text('Hello thumb world'), findsNWidgets(2));
  });

  testWidgets('control: non-reverse detail body lays out title', (tester) async {
    WebSession.instance.reverseDetails.value = false;
    await tester.pumpWidget(
      MaterialApp(
        home: DetailScreen(
          items: [
            WebDiscoveryIllust('1', 'Hello thumb world',
                profileImageUrl: 'https://example.invalid/a.jpg')
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Retry'), findsWidgets);

    // Mirror drag for the normal order (info sits below the viewer there).
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pump();

    expect(find.text('Hello thumb world'), findsNWidgets(2));
  });
}
