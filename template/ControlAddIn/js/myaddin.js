function InitMyAddIn() {
    const root = document.getElementById('controlAddIn');
    root.innerHTML = `
        <div class="ma-wrapper">
            <span id="ma-text">Ready</span>
            <button type="button" id="ma-btn">Click me</button>
        </div>`;

    document.getElementById('ma-btn').addEventListener('click', function () {
        // JS → AL
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SomethingHappened', ['clicked']);
    });
}

// AL → JS: procedure DoSomething(Value: Text)
function DoSomething(value) {
    document.getElementById('ma-text').textContent = value;
}
