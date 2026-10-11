namespace BCAddinHub.TrafficLight;

controladdin TrafficLight
{
    RequestedHeight = 50;
    MinimumHeight = 50;
    RequestedWidth = 250;
    VerticalStretch = false;
    HorizontalStretch = true;

    Scripts = 'ControlAddIn/js/trafficlight.js';
    StartupScript = 'ControlAddIn/js/startup.js';
    StyleSheets = 'ControlAddIn/css/trafficlight.css';

    /// <summary>Raised once the add-in is loaded. Do not call procedures before this event.</summary>
    event ControlReady();

    /// <summary>Raised when the user clicks the light. Status is 'red', 'yellow' or 'green'.</summary>
    event LightClicked(Status: Text);

    /// <summary>Switches the light. Status: 'red', 'yellow', 'green' or '' (all off).</summary>
    procedure SetStatus(Status: Text; Caption: Text);
}
