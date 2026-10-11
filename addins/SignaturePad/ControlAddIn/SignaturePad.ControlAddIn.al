namespace BCAddinHub.SignaturePad;

controladdin SignaturePad
{
    RequestedHeight = 260;
    MinimumHeight = 220;
    RequestedWidth = 500;
    MinimumWidth = 300;
    VerticalStretch = true;
    HorizontalStretch = true;

    Scripts = 'ControlAddIn/js/signaturepad.js';
    StartupScript = 'ControlAddIn/js/startup.js';
    StyleSheets = 'ControlAddIn/css/signaturepad.css';

    /// <summary>Raised once the add-in is loaded.</summary>
    event ControlReady();

    /// <summary>Raised when the user clicks Save. Base64Png is a PNG without the "data:image/png;base64," prefix.</summary>
    event SignatureSaved(Base64Png: Text);

    /// <summary>Raised when the user clicks Save without having drawn anything.</summary>
    event SignatureEmpty();

    /// <summary>Clears the drawing area.</summary>
    procedure Clear();

    /// <summary>Sets translated captions for the buttons and the hint text.</summary>
    procedure SetLabels(ClearCaption: Text; SaveCaption: Text; HintCaption: Text);
}
