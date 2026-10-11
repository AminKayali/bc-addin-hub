// Runs once when the iframe of the control add-in has loaded.
InitSalesChart();

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
