import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'feed_screen.dart';
import 'web_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WebSession.instance.init();
  runApp(const PixivApp());
}

class PixivApp extends StatelessWidget {
  const PixivApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixiv',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
        },
      ),
      home: const FeedScreen(),
    );
  }
}
