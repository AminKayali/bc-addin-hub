# Bar Chart (SVG)

A small, dependency-free bar chart. AL sends the data as JSON, the add-in draws an SVG and reports clicks back to AL.

![Category](https://img.shields.io/badge/category-Visualization-blue) ![Target](https://img.shields.io/badge/target-Cloud-green) ![Dependencies](https://img.shields.io/badge/external%20libs-none-lightgrey)

## What the example does

Adds a **Sales Trend** FactBox to the **Customer Card**: sales (LCY) of the last 12 months from the customer ledger entries. Clicking a bar opens the ledger entries of that month.

## Interface

| Direction | Member | Description |
|---|---|---|
| JS → AL | `event ControlReady()` | Add-in has loaded. |
| JS → AL | `event BarClicked("Key": Text)` | User clicked a bar; returns the `key` of the data point. |
| AL → JS | `procedure Render(DataJson: Text)` | Draws the chart. |

### JSON format

```json
{
  "title": "Sales, last 12 months",
  "currency": "EUR",
  "points": [
    { "key": "2025-11-01", "label": "Nov 25", "value": 12450.0 },
    { "key": "2025-12-01", "label": "Dec 25", "value": -300.0 }
  ]
}
```

`key` is free text and is handed back unchanged in `BarClicked`, so you can use any identifier (date, item no., salesperson code …). Negative values are drawn in red below the zero line.

## Why no Chart.js?

Bundling a library is fine (put the minified file into the extension and reference it in `Scripts`), but it adds weight and a license to track. For a simple bar chart ~150 lines of plain JavaScript are enough and work fully offline. Feel free to contribute a Chart.js-based variant as a separate add-in.

## Notes

- The data is computed in AL with `CalcSums`, the add-in only renders.
- Object IDs 50120–50129. Renumber when you copy the add-in into your own app.
