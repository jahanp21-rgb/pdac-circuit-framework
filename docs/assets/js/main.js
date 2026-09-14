// PDAC Circuit Framework — Main JS
document.addEventListener('DOMContentLoaded', () => {
  // Animate bars on scroll
  const bars = document.querySelectorAll('.bar');
  if (bars.length) {
    const widths = [];
    bars.forEach(b => { widths.push(b.style.width); b.style.width = '0'; });
    setTimeout(() => bars.forEach((b, i) => { b.style.transition = 'width 1.2s cubic-bezier(.4,0,.2,1)'; b.style.width = widths[i]; }), 400);
  }
  // Smooth active nav highlight
  const path = window.location.pathname;
  document.querySelectorAll('.nav-links a').forEach(a => {
    if (path.includes(a.getAttribute('href').replace('../',''))) a.classList.add('active');
  });
});
