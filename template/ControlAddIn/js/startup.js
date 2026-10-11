// Runs once when the iframe of the control add-in has loaded.
InitMyAddIn();

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
