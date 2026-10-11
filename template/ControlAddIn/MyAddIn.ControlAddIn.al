namespace BCAddinHub.MyAddIn;

controladdin MyAddIn
{
    RequestedHeight = 200;
    MinimumHeight = 100;
    RequestedWidth = 300;
    VerticalStretch = false;
    HorizontalStretch = true;

    Scripts = 'ControlAddIn/js/myaddin.js';
    StartupScript = 'ControlAddIn/js/startup.js';
    StyleSheets = 'ControlAddIn/css/myaddin.css';

    /// <summary>Raised once the add-in is loaded. Do not call procedures before this event.</summary>
    event ControlReady();

    /// <summary>Example event JS → AL.</summary>
    event SomethingHappened(Value: Text);

    /// <summary>Example procedure AL → JS.</summary>
    procedure DoSomething(Value: Text);
}
