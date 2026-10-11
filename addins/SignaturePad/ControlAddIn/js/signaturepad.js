let sp = {
    canvas: null,
    ctx: null,
    drawing: false,
    hasInk: false,
    last: null
};

function InitSignaturePad() {
    const root = document.getElementById('controlAddIn');
    root.innerHTML = `
        <div class="sp-wrapper">
            <div class="sp-area">
                <canvas id="sp-canvas"></canvas>
                <div class="sp-hint" id="sp-hint">Sign here</div>
                <div class="sp-line"></div>
            </div>
            <div class="sp-buttons">
                <button type="button" id="sp-clear" class="sp-btn">Clear</button>
                <button type="button" id="sp-save" class="sp-btn sp-primary">Save</button>
            </div>
        </div>`;

    sp.canvas = document.getElementById('sp-canvas');
    sp.ctx = sp.canvas.getContext('2d');

    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    sp.canvas.addEventListener('pointerdown', onPointerDown);
    sp.canvas.addEventListener('pointermove', onPointerMove);
    sp.canvas.addEventListener('pointerup', onPointerUp);
    sp.canvas.addEventListener('pointerleave', onPointerUp);
    sp.canvas.addEventListener('pointercancel', onPointerUp);

    document.getElementById('sp-clear').addEventListener('click', Clear);
    document.getElementById('sp-save').addEventListener('click', save);
}

// Keeps the drawing sharp on high-DPI screens. Note: resizing clears the canvas.
function resizeCanvas() {
    const rect = sp.canvas.getBoundingClientRect();
    const ratio = window.devicePixelRatio || 1;
    sp.canvas.width = Math.max(1, Math.floor(rect.width * ratio));
    sp.canvas.height = Math.max(1, Math.floor(rect.height * ratio));
    sp.ctx.setTransform(ratio, 0, 0, ratio, 0, 0);
    sp.ctx.lineWidth = 2.2;
    sp.ctx.lineCap = 'round';
    sp.ctx.lineJoin = 'round';
    sp.ctx.strokeStyle = '#1a1a1a';
    setInk(false);
}

function pointFrom(e) {
    const rect = sp.canvas.getBoundingClientRect();
    return { x: e.clientX - rect.left, y: e.clientY - rect.top };
}

function onPointerDown(e) {
    e.preventDefault();
    sp.canvas.setPointerCapture(e.pointerId);
    sp.drawing = true;
    sp.last = pointFrom(e);
    // Draw a dot so a single tap is visible.
    sp.ctx.beginPath();
    sp.ctx.arc(sp.last.x, sp.last.y, sp.ctx.lineWidth / 2, 0, Math.PI * 2);
    sp.ctx.fillStyle = sp.ctx.strokeStyle;
    sp.ctx.fill();
    setInk(true);
}

function onPointerMove(e) {
    if (!sp.drawing) return;
    e.preventDefault();
    const p = pointFrom(e);
    sp.ctx.beginPath();
    sp.ctx.moveTo(sp.last.x, sp.last.y);
    sp.ctx.lineTo(p.x, p.y);
    sp.ctx.stroke();
    sp.last = p;
}

function onPointerUp() {
    sp.drawing = false;
}

function setInk(value) {
    sp.hasInk = value;
    document.getElementById('sp-hint').style.visibility = value ? 'hidden' : 'visible';
}

function save() {
    if (!sp.hasInk) {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SignatureEmpty', []);
        return;
    }
    // Export on a white background so the PNG looks right in reports.
    const out = document.createElement('canvas');
    out.width = sp.canvas.width;
    out.height = sp.canvas.height;
    const octx = out.getContext('2d');
    octx.fillStyle = '#ffffff';
    octx.fillRect(0, 0, out.width, out.height);
    octx.drawImage(sp.canvas, 0, 0);

    const base64 = out.toDataURL('image/png').split(',')[1];
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SignatureSaved', [base64]);
}

// Called from AL: procedure Clear()
function Clear() {
    sp.ctx.clearRect(0, 0, sp.canvas.width, sp.canvas.height);
    setInk(false);
}

// Called from AL: procedure SetLabels(ClearCaption; SaveCaption; HintCaption)
function SetLabels(clearCaption, saveCaption, hintCaption) {
    document.getElementById('sp-clear').textContent = clearCaption;
    document.getElementById('sp-save').textContent = saveCaption;
    document.getElementById('sp-hint').textContent = hintCaption;
}
