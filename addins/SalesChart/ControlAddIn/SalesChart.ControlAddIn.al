namespace BCAddinHub.SalesChart;

controladdin SalesChart
{
    RequestedHeight = 220;
    MinimumHeight = 180;
    RequestedWidth = 300;
    VerticalStretch = false;
    HorizontalStretch = true;

    Scripts = 'ControlAddIn/js/saleschart.js';
    StartupScript = 'ControlAddIn/js/startup.js';
    StyleSheets = 'ControlAddIn/css/saleschart.css';

    /// <summary>Raised once the add-in is loaded.</summary>
    event ControlReady();

    /// <summary>Raised when a bar is clicked. Key is the "key" value of that data point.</summary>
    event BarClicked("Key": Text);

    /// <summary>
    /// Draws the chart. DataJson format:
    /// {"title":"...","currency":"EUR","points":[{"key":"2026-01-01","label":"Jan 26","value":1234.5}, ...]}
    /// </summary>
    procedure Render(DataJson: Text);
}
