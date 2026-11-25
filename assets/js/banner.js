/* Banner galeri gaya Netflix: crossfade + Ken Burns, autoplay dengan progress, swipe, pause off-screen. */
(function () {
  'use strict';
  var root = document.querySelector('[data-nf]');
  if (!root) return;
  var slides = root.querySelectorAll('[data-nf-slide]');
  var infos = root.querySelectorAll('[data-nf-info]');
  var thumbs = root.querySelectorAll('[data-nf-thumb]');
  var count = root.querySelector('[data-nf-count]');
  var toggle = root.querySelector('[data-nf-toggle]');
  var row = root.querySelector('[data-nf-row]');
  var n = slides.length;
  var reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var DUR = 7000;
  var cur = 0, timer = 0, startAt = 0, left = DUR, paused = reduce, visible = false;

  root.style.setProperty('--nf-dur', DUR + 'ms');
  function pad(x) { return (x < 10 ? '0' : '') + x; }
  function load(i) {
    var img = slides[i] && slides[i].querySelector('img');
    if (!img || !img.dataset.src) return;
    if (img.dataset.srcset) { img.srcset = img.dataset.srcset; img.removeAttribute('data-srcset'); }
    img.src = img.dataset.src; img.removeAttribute('data-src');
  }

  function go(i, user) {
    if (n < 2) return;
    i = (i + n) % n;
    if (i === cur) return;
    load(i); load((i + 1) % n);
    slides[cur].classList.remove('is-active'); slides[cur].setAttribute('aria-hidden', 'true');
    infos[cur].classList.remove('is-active'); infos[cur].hidden = true;
    if (thumbs[cur]) { thumbs[cur].classList.remove('is-active'); thumbs[cur].setAttribute('aria-selected', 'false'); }
    cur = i;
    slides[cur].classList.add('is-active'); slides[cur].removeAttribute('aria-hidden');
    infos[cur].hidden = false;
    void infos[cur].offsetWidth;
    infos[cur].classList.add('is-active');
    if (thumbs[cur]) {
      thumbs[cur].classList.add('is-active'); thumbs[cur].setAttribute('aria-selected', 'true');
      if (row && user !== 'init') {
        var t = thumbs[cur], target = t.offsetLeft - (row.clientWidth - t.clientWidth) / 2;
        row.scrollTo({ left: Math.max(0, target), behavior: reduce ? 'auto' : 'smooth' });
      }
    }
    if (count) count.textContent = pad(cur + 1) + ' / ' + pad(n);
    left = DUR; schedule();
  }

  function clear() { clearTimeout(timer); timer = 0; }
  function schedule() {
    clear();
    if (paused || !visible || document.hidden || n < 2) { root.classList.add('is-paused'); return; }
    root.classList.remove('is-paused');
    startAt = Date.now();
    timer = setTimeout(function () { go(cur + 1); }, left);
  }
  function hold() { if (timer) { left = Math.max(400, left - (Date.now() - startAt)); } clear(); root.classList.add('is-paused'); }

  function setPaused(p) {
    paused = p;
    if (toggle) {
      toggle.innerHTML = p ? '<i class="bi bi-play-fill"></i>' : '<i class="bi bi-pause-fill"></i>';
      toggle.setAttribute('aria-label', p ? 'Putar slider' : 'Jeda slider');
    }
    p ? hold() : schedule();
  }

  var prev = root.querySelector('[data-nf-prev]'), next = root.querySelector('[data-nf-next]');
  prev && prev.addEventListener('click', function () { go(cur - 1, true); });
  next && next.addEventListener('click', function () { go(cur + 1, true); });
  toggle && toggle.addEventListener('click', function () { setPaused(!paused); });
  Array.prototype.forEach.call(thumbs, function (t) {
    t.addEventListener('click', function () { go(parseInt(t.dataset.nfThumb, 10), true); });
  });

  var stage = root.querySelector('[data-nf-stage]');
  if (window.matchMedia('(hover: hover) and (pointer: fine)').matches) {
    stage.addEventListener('mouseenter', function () { if (!paused) hold(); });
    stage.addEventListener('mouseleave', function () { if (!paused) schedule(); });
  }
  var sx = 0, sy = 0, tracking = false;
  stage.addEventListener('touchstart', function (e) { var p = e.touches[0]; sx = p.clientX; sy = p.clientY; tracking = true; }, { passive: true });
  stage.addEventListener('touchend', function (e) {
    if (!tracking) return; tracking = false;
    var p = e.changedTouches[0], dx = p.clientX - sx, dy = p.clientY - sy;
    if (Math.abs(dx) > 45 && Math.abs(dx) > Math.abs(dy) * 1.4) go(cur + (dx < 0 ? 1 : -1), true);
  }, { passive: true });
  root.addEventListener('keydown', function (e) {
    if (e.key === 'ArrowRight') go(cur + 1, true);
    else if (e.key === 'ArrowLeft') go(cur - 1, true);
  });
  document.addEventListener('visibilitychange', function () { document.hidden ? hold() : schedule(); });

  if ('IntersectionObserver' in window) {
    new IntersectionObserver(function (en) {
      visible = en[0].isIntersecting;
      if (visible) { root.classList.add('is-inview'); load(1 % n); schedule(); } else hold();
    }, { threshold: 0.25 }).observe(root);
  } else { visible = true; root.classList.add('is-inview'); schedule(); }

  if (paused && toggle) setPaused(true);
})();
