# Traffic Light

A red / yellow / green status light that raises an event when clicked.

![Category](https://img.shields.io/badge/category-Status-blue) ![Target](https://img.shields.io/badge/target-Cloud-green) ![Dependencies](https://img.shields.io/badge/external%20libs-none-lightgrey)

## What the example does

Adds a **Delivery Status** FactBox to the **Sales Order List**:

| Light | Meaning |
|---|---|
| 🔴 Red | At least one open item line with a shipment date before the work date |
| 🟡 Yellow | Open quantities, but on schedule |
| 🟢 Green | Fully shipped |

Clicking the light opens the open sales lines of the order.

## Interface

| Direction | Member | Description |
|---|---|---|
| JS → AL | `event ControlReady()` | Add-in has loaded. Only call procedures after this. |
| JS → AL | `event LightClicked(Status: Text)` | User clicked the light. |
| AL → JS | `procedure SetStatus(Status: Text; Caption: Text)` | `Status` is `red`, `yellow`, `green` or empty. |

## Files

```
TrafficLight/
├── ControlAddIn/
│   ├── TrafficLight.ControlAddIn.al
│   ├── js/startup.js
│   ├── js/trafficlight.js
│   └── css/trafficlight.css
└── src/                                 ← example usage
    ├── OrderTrafficLightMgt.Codeunit.al
    ├── OrderTrafficLightFactBox.Page.al
    └── SalesOrderListExt.PageExt.al
```

## Notes

- Control add-ins cannot be placed inside a repeater (per list row). For a per-row light use `StyleExpr` on a field instead.
- Object IDs 50100–50109. Renumber when you copy the add-in into your own app.
