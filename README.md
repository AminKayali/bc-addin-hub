# BC AddIn Hub

**A community-driven collection of ready-to-use JavaScript control add-ins for Microsoft Dynamics 365 Business Central.**
Copy one into your extension, adapt it, or contribute your own.

![License](https://img.shields.io/badge/license-MIT-blue) ![Target](https://img.shields.io/badge/target-Cloud-green) ![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)

## Why?

Since the Windows client is gone, `controladdin` objects with JavaScript are the only way to bring custom UI into Business Central Online. Most of us write the same things again and again – a status light, a chart, a signature field. This repository collects them in one place, each one:

- **self-contained** – one folder, one `app.json`, press F5 and it runs
- **dependency-free where possible** – plain JavaScript, no CDN links
- **Cloud-ready** – compiles with `"target": "Cloud"`
- **with a real example** – not just the control, but a page/FactBox that uses it

## Add-ins

See the full, generated list in **[CATALOG.md](CATALOG.md)**.

| Add-in | What it does | Example |
|---|---|---|
| [Traffic Light](addins/TrafficLight) | Red/yellow/green status light with click event | Delivery status FactBox on the Sales Order List |
| [Signature Pad](addins/SignaturePad) | Handwritten signature (mouse, pen, touch) as PNG | Sign a Posted Sales Shipment |
| [Bar Chart (SVG)](addins/SalesChart) | JSON-fed bar chart with drill-down | Customer sales of the last 12 months |

## Quick start

```bash
git clone https://github.com/bc-addin-hub/bc-addin-hub.git
code bc-addin-hub/addins/TrafficLight
```

Then `AL: Download Symbols` and `F5`. More in [docs/getting-started.md](docs/getting-started.md).

## Repository structure

```
bc-addin-hub/
├── addins/               ← one folder per add-in, each a standalone AL project
│   ├── TrafficLight/
│   ├── SignaturePad/
│   └── SalesChart/
├── template/             ← copy this to start a new add-in
├── docs/                 ← getting started, patterns
├── scripts/              ← catalog generator
├── CATALOG.md            ← generated from addins/*/addin.json
└── catalog.json          ← same data, machine-readable
```

## Contributing

Ideas, bug reports and new add-ins are very welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) and use the issue templates.

## Disclaimer

The add-ins are provided as-is under the MIT license. Review the code before you use it in production. This project is not affiliated with Microsoft.
