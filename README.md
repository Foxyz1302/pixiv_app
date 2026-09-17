# pixiv_app

Personal Pixiv browser (web-ajax API, cookie auth). Discovery with R18,
masonry feed, swipeable detail, progressive ugoira playback.

Run: `flutter run -d linux` (desktop debug) or `flutter run` on Android.
First launch: paste `PHPSESSID` in Settings (one time; session renews on use).
Live API checks: `dart run tool/check_web_client.dart cookies.json`.

Docs: `docs/api_map.md` (endpoint map), `docs/roadmap.md` (scope).
