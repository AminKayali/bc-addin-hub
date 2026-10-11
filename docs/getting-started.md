# Getting started

## Try an add-in

1. Clone the repository.
2. Open the add-in folder (e.g. `addins/TrafficLight`) in VS Code with the AL Language extension.
3. Create `.vscode/launch.json` for your sandbox (`AL: Go!` or copy one from another project).
4. Run `AL: Download Symbols`, then `F5`.

## Use an add-in in your own extension

1. Copy the `ControlAddIn/` folder into your app (e.g. to `src/ControlAddIns/<Name>/`).
2. Adjust the paths in `Scripts`, `StartupScript` and `StyleSheets` – they are relative to the folder containing `app.json`.
3. Rename the namespace (or remove it) and add your affix to the `controladdin` name if you publish to AppSource.
4. Look at `src/` of the add-in for how to place it with `usercontrol` and handle its events.

## How a control add-in talks to AL

```
AL  ──── procedure ────▶  JavaScript      CurrPage.MyControl.DoSomething('x');
AL  ◀──── event ───────  JavaScript      Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SomethingHappened', ['x']);
```

All calls are asynchronous, procedures have no return value. Send results back with an event.

## Debugging

- `F12` in the browser, switch the console context to the add-in's iframe.
- After changing JS/CSS, hard-reload (`Ctrl+F5`) or clear the browser cache.
- Nothing shows up? Check the file paths and that procedure/event names match the JS exactly (case-sensitive).

## Official documentation

- [Control add-in object](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-control-addin-object)
- [Asynchronous considerations](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-control-addin-asynchronous-considerations)
- [Best practices](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-control-addin-best-practices)
- [Style guide](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-control-addin-style-guide)
- [Training: Build control add-in objects](https://learn.microsoft.com/en-us/training/modules/build-control-add-ins/)
