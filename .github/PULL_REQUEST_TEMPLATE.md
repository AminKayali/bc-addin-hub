## What does this PR add or change?

<!-- New add-in, fix, improvement … -->

## Checklist

- [ ] One add-in per folder in `addins/<Name>/`, folder name = `name` in `addin.json`
- [ ] `addin.json`, `app.json`, `README.md` (with interface table) are present
- [ ] Startup script raises `ControlReady`; AL only calls procedures after it
- [ ] No external URLs in `Scripts` / `StyleSheets` (bundle libraries in the folder)
- [ ] Bundled libraries are listed in `externalDependencies` and their license file is included
- [ ] No `eval`, no data sent to third-party services
- [ ] Compiles with `"target": "Cloud"` (or the reason for OnPrem is documented)
- [ ] Tested in Business Central (version: …)
- [ ] Screenshot or GIF in the add-in README
- [ ] `node scripts/build-catalog.mjs` run and `CATALOG.md` committed
