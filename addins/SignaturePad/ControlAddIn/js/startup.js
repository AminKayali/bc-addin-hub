// Runs once when the iframe of the control add-in has loaded.
InitSignaturePad();

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
