# pixiv_app (name TBD)

A mobile Pixiv browser. The goal is a client that doesn't suck to use with one thumb.

## Why

The public mobile API is limited, and every third-party app built on it inherits the same gaps plus its own bad UI. The web API has everything, but then you're stuck in a browser.

So this uses the web API directly, wrapped in an app that actually feels like an app.

## What works

- Discovery feed (All / Safe / R18) in a masonry grid
- Swipeable detail view, multi-page posts included
- Ugoira player that starts playing before the full animation is downloaded. Still rough, needs optimization. Scrubbing planned.
- Artist pages + "more from this artist" strip with prev/next
- Related posts with load-more
- Disk cache for images and ugoira zips
- Reverse mode (experimental): flips the detail view so the artwork sits at the bottom. Meant for one-handed use, still being figured out.

## What's missing

Right now discovery is the only way in, which isn't great. Planned:

- Popular feed
- Followed feed
- Search + tags
- Following / favoriting

Branding is also undecided. Name, icon, all of it.

## Login

Paste your `PHPSESSID` cookie once in Settings. It auto-renews when you use the app — just open it at least once every ~30 days and the session stays alive.

Don't share this cookie with anyone, it's your login.

1. Log into pixiv.net in a browser
2. Copy the `PHPSESSID` cookie value
3. Open the app → gear icon → paste → Save

## Run

```bash
flutter run
