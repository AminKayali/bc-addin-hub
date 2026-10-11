const SVG_NS = 'http://www.w3.org/2000/svg';
let lastData = null;

function InitSalesChart() {
    const root = document.getElementById('controlAddIn');
    root.innerHTML = `
        <div class="sc-wrapper">
            <div class="sc-header">
                <span class="sc-title" id="sc-title"></span>
                <span class="sc-total" id="sc-total"></span>
            </div>
            <div class="sc-chart" id="sc-chart"></div>
            <div class="sc-tooltip" id="sc-tooltip"></div>
        </div>`;

    // Redraw on resize so the bars always fill the available width.
    let t;
    window.addEventListener('resize', function () {
        clearTimeout(t);
        t = setTimeout(function () { if (lastData) draw(lastData); }, 100);
    });
}

// Called from AL: procedure Render(DataJson: Text)
function Render(dataJson) {
    try {
        lastData = JSON.parse(dataJson);
    } catch (e) {
        console.error('SalesChart: invalid JSON', e);
        return;
    }
    draw(lastData);
}

function formatAmount(value, currency) {
    const lang = (navigator.language || 'en-US');
    const num = new Intl.NumberFormat(lang, { maximumFractionDigits: 0 }).format(value);
    return currency ? num + ' ' + currency : num;
}

function formatShort(value) {
    const abs = Math.abs(value);
    if (abs >= 1e6) return (value / 1e6).toFixed(1).replace(/\.0$/, '') + 'M';
    if (abs >= 1e3) return (value / 1e3).toFixed(1).replace(/\.0$/, '') + 'k';
    return String(Math.round(value));
}

function el(name, attrs) {
    const node = document.createElementNS(SVG_NS, name);
    for (const k in attrs) node.setAttribute(k, attrs[k]);
    return node;
}

function draw(data) {
    const points = data.points || [];
    const container = document.getElementById('sc-chart');
    const tooltip = document.getElementById('sc-tooltip');
    container.innerHTML = '';

    const total = points.reduce(function (s, p) { return s + (p.value || 0); }, 0);
    document.getElementById('sc-title').textContent = data.title || '';
    document.getElementById('sc-total').textContent = formatAmount(total, data.currency);

    if (points.length === 0) {
        container.innerHTML = '<div class="sc-empty">–</div>';
        return;
    }

    const width = Math.max(container.clientWidth, 200);
    const height = Math.max(container.clientHeight, 120);
    const pad = { top: 8, right: 4, bottom: 20, left: 34 };
    const plotW = width - pad.left - pad.right;
    const plotH = height - pad.top - pad.bottom;

    const max = Math.max.apply(null, points.map(function (p) { return p.value; }).concat([0]));
    const min = Math.min.apply(null, points.map(function (p) { return p.value; }).concat([0]));
    const range = (max - min) || 1;
    const y = function (v) { return pad.top + plotH - ((v - min) / range) * plotH; };

    const svg = el('svg', { width: width, height: height, viewBox: '0 0 ' + width + ' ' + height, role: 'img' });

    // Gridlines: zero line, and max.
    [min, 0, max].filter(function (v, i, a) { return a.indexOf(v) === i; }).forEach(function (v) {
        svg.appendChild(el('line', { x1: pad.left, x2: width - pad.right, y1: y(v), y2: y(v), class: v === 0 ? 'sc-axis' : 'sc-grid' }));
        const lbl = el('text', { x: pad.left - 4, y: y(v) + 3, class: 'sc-ylabel', 'text-anchor': 'end' });
        lbl.textContent = formatShort(v);
        svg.appendChild(lbl);
    });

    const slot = plotW / points.length;
    const barW = Math.max(2, Math.min(28, slot * 0.7));
    const labelEvery = Math.ceil(points.length / Math.max(1, Math.floor(plotW / 34)));

    points.forEach(function (p, i) {
        const cx = pad.left + slot * i + slot / 2;
        const top = Math.min(y(p.value), y(0));
        const h = Math.max(1, Math.abs(y(p.value) - y(0)));

        const bar = el('rect', {
            x: cx - barW / 2, y: top, width: barW, height: h, rx: 2,
            class: 'sc-bar' + (p.value < 0 ? ' sc-neg' : ''),
            tabindex: 0
        });
        const show = function () {
            tooltip.textContent = p.label + ': ' + formatAmount(p.value, data.currency);
            tooltip.style.left = Math.min(Math.max(cx - 60, 0), width - 120) + 'px';
            tooltip.style.top = Math.max(top - 30, 0) + 'px';
            tooltip.style.visibility = 'visible';
        };
        const hide = function () { tooltip.style.visibility = 'hidden'; };
        const click = function () {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('BarClicked', [String(p.key)]);
        };
        bar.addEventListener('mouseenter', show);
        bar.addEventListener('focus', show);
        bar.addEventListener('mouseleave', hide);
        bar.addEventListener('blur', hide);
        bar.addEventListener('click', click);
        bar.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); click(); }
        });
        svg.appendChild(bar);

        if (i % labelEvery === 0) {
            const xl = el('text', { x: cx, y: height - 6, class: 'sc-xlabel', 'text-anchor': 'middle' });
            xl.textContent = p.label;
            svg.appendChild(xl);
        }
    });

    container.appendChild(svg);
}
