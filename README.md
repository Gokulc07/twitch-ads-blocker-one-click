# Twitch Ads Blocker (Easy Wrapper)

This is a simple Twitch ad-block extension wrapper based on `vaft` from [pixeltris/TwitchAdSolutions](https://github.com/pixeltris/TwitchAdSolutions).

You do **not** need to publish to any store to use it.

## For normal users (no store needed)

### 1) Download this project

1. Open the repo on GitHub.
2. Click **Code** -> **Download ZIP**.
3. Unzip it anywhere on your computer.

### 2) Install on Chrome / Edge / Brave / Opera / Vivaldi

1. Open extension settings:
   - Chrome/Brave/Opera/Vivaldi: `chrome://extensions`
   - Edge: `edge://extensions`
2. Turn on **Developer mode**.
3. Click **Load unpacked**.
4. Select the `extension` folder inside this project.
5. Open Twitch and test a stream.

### 3) Install on Firefox (without AMO)

1. Open: `about:debugging#/runtime/this-firefox`
2. Click **Load Temporary Add-on**.
3. Select `extension/manifest.json` from this project.

Note: Firefox temporary add-ons are removed when Firefox restarts. You need to load it again after restart.

### 4) Use it

1. Open Twitch.
2. Click the extension icon.
3. Keep **Ad Blocking** ON.
4. Keep **Watchdog Recovery** ON (recommended).
5. If stream is stuck, click **Reload Twitch Tab**.
6. If popup shows a conflict warning, disable other Twitch ad blockers.

### 5) Update later

Option A (easy): download latest ZIP from GitHub and load unpacked again.

Option B (terminal): from project folder run:

```bash
./scripts/update-vaft.sh
```

Then go back to your extensions page and click **Reload** on this extension.

## Troubleshooting (quick)

- Use only one Twitch ad blocker at a time.
- Reload the extension from the browser extensions page.
- Refresh Twitch tab.
- Restart browser if needed.

## Developer-only section

These are for maintainers/publishers, not normal users.

### Automated upstream sync

- Workflow: `.github/workflows/upstream-sync.yml`
- Runs daily at `07:19 UTC`.
- Opens a PR automatically when upstream `vaft` changes.

### Store packaging (developer only)

Build store zips:

```bash
./scripts/package-stores.sh
```

Optional Firefox ID override:

```bash
FIREFOX_EXTENSION_ID="your-addon-id@example.com" ./scripts/package-stores.sh
```

Artifacts are created in `dist/stores/<version>/`.

Also available via manual GitHub Actions workflow:

- `.github/workflows/store-packages.yml`

Full release checklist:

- `docs/store-publish-checklist.md`

## Limitations

- Twitch ad delivery changes often, so breakage can happen without warning.
- Any ad-blocking method may intermittently buffer or freeze depending on current Twitch behavior.
- Watchdog may trigger pause/play or tab reload if playback appears stalled for too long.
- This project cannot guarantee ad-free playback in every stream/browser combination.

## Attribution

Core ad-block logic is from `pixeltris/TwitchAdSolutions` (`vaft`), licensed under MIT.

- upstream repo: <https://github.com/pixeltris/TwitchAdSolutions>
- license copy: `third_party/LICENSE-pixeltris-TwitchAdSolutions.txt`
