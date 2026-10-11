# Signature Pad

Capture a handwritten signature with mouse, pen or finger and hand it to AL as a Base64 PNG.

![Category](https://img.shields.io/badge/category-Input-blue) ![Target](https://img.shields.io/badge/target-Cloud-green) ![Dependencies](https://img.shields.io/badge/external%20libs-none-lightgrey)

## What the example does

- Adds the action **Capture Signature** to the **Posted Sales Shipment** page.
- Opens a dialog with a name field and the signature pad.
- On **Save** the PNG is stored in a `Media` field on the `Sales Shipment Header`, together with *Signed By* and *Signed At*.
- The signature can then be printed on the shipment report (e.g. ForNAV or RDLC/Word layout via the `Signature` field).

## Interface

| Direction | Member | Description |
|---|---|---|
| JS → AL | `event ControlReady()` | Add-in has loaded. |
| JS → AL | `event SignatureSaved(Base64Png: Text)` | User clicked Save. PNG without `data:` prefix, white background. |
| JS → AL | `event SignatureEmpty()` | User clicked Save without signing. |
| AL → JS | `procedure Clear()` | Clears the pad. |
| AL → JS | `procedure SetLabels(ClearCaption; SaveCaption; HintCaption: Text)` | Translated captions. |

## Notes

- Uses Pointer Events, so mouse, pen and touch work in the browser and in the mobile apps.
- `touch-action: none` on the canvas prevents the page from scrolling while signing.
- Resizing the window clears the pad (by design, keeps the drawing sharp).
- Object IDs 50110–50119. Renumber when you copy the add-in into your own app.
