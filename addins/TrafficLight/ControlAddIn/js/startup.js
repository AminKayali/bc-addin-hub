// Runs once when the iframe of the control add-in has loaded.
InitTrafficLight();

// Tell AL that the add-in is ready to receive calls.
Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
