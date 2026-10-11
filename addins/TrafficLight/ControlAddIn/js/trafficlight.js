let currentStatus = '';

function InitTrafficLight() {
    const root = document.getElementById('controlAddIn');
    root.innerHTML = `
        <div class="tl-wrapper">
            <div class="tl-box" role="button" tabindex="0">
                <div class="tl-lamp" id="tl-red"></div>
                <div class="tl-lamp" id="tl-yellow"></div>
                <div class="tl-lamp" id="tl-green"></div>
            </div>
            <div class="tl-caption" id="tl-caption"></div>
        </div>`;

    const box = root.querySelector('.tl-box');
    const raiseClick = function () {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('LightClicked', [currentStatus]);
    };
    box.addEventListener('click', raiseClick);
    box.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            raiseClick();
        }
    });
}

// Called from AL: procedure SetStatus(Status: Text; Caption: Text)
function SetStatus(status, caption) {
    currentStatus = status;
    ['red', 'yellow', 'green'].forEach(function (color) {
        document.getElementById('tl-' + color).classList.toggle('on', color === status);
    });
    document.getElementById('tl-caption').textContent = caption;
    document.querySelector('.tl-box').setAttribute('aria-label', caption);
}
