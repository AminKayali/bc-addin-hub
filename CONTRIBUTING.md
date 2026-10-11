# Contributing

Thanks for helping to grow the collection! Every add-in should be something another developer can **copy into their own extension in a few minutes**.

## Add a new add-in

1. Fork the repository and create a branch `addin/<Name>`.
2. Copy `template/` to `addins/<Name>/` (PascalCase, e.g. `addins/ProgressRing/`).
3. Rename `MyAddIn` everywhere (files, `controladdin` name, namespace, JS functions).
4. Fill in `addin.json` and `app.json`:
   - new GUID in `app.json`
   - pick a free ID range of 10 objects (see the table below) and add it to the table in your PR
5. Build the control in `ControlAddIn/` and a small, realistic example in `src/`.
6. Write the `README.md` (what it does, interface table, screenshot).
7. Run `node scripts/build-catalog.mjs` and commit `CATALOG.md` and `catalog.json`.
8. Open a pull request and fill in the checklist.

## Folder layout of an add-in

```
addins/<Name>/
├── addin.json                 ← catalog metadata
├── app.json                   ← standalone AL project, F5-ready
├── README.md
├── ControlAddIn/              ← the reusable part: copy this into your app
│   ├── <Name>.ControlAddIn.al
│   ├── js/startup.js
│   ├── js/<name>.js
│   ├── css/<name>.css
│   └── lib/                   ← optional bundled libraries + their license
└── src/                       ← example usage (pages, codeunits, extensions)
```

## Rules

- **Cloud first.** Everything must compile with `"target": "Cloud"`. No DotNet.
- **ControlReady pattern.** The startup script raises `ControlReady`; AL calls procedures only after that event.
- **Logic in AL, rendering in JS.** Calculations, permissions and data access belong in AL.
- **No external URLs** in `Scripts`/`StyleSheets`. Bundle libraries in `lib/` with their license file and list them in `externalDependencies`.
- **No tracking, no `eval`, no data to third parties.** Reviewers will reject this.
- **Accessible.** Keyboard support (`tabindex`, Enter/Space) for clickable elements.
- **Look like Business Central.** Segoe UI, Fluent colors, see the [style guide](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-control-addin-style-guide).
- **Translatable.** Captions shown in JS can be set from AL (`SetLabels`-style procedure) so they come from AL labels.
- **English** for code, comments and READMEs.

## ID ranges

| Range | Add-in |
|---|---|
| 50000–50009 | template |
| 50100–50109 | TrafficLight |
| 50110–50119 | SignaturePad |
| 50120–50129 | SalesChart |
| 50130–… | next free |

IDs only matter inside this repository. When you copy an add-in into your own app, renumber the objects.
