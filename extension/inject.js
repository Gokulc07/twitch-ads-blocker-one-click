(() => {
  const scriptId = 'twitchadsblocker-vaft';
  if (document.getElementById(scriptId)) {
    return;
  }

  const runtime = globalThis.chrome?.runtime ?? globalThis.browser?.runtime;
  if (!runtime?.getURL) {
    return;
  }

  const script = document.createElement('script');
  script.id = scriptId;
  script.src = runtime.getURL('injected/vaft.js');
  script.async = false;

  (document.head || document.documentElement).appendChild(script);
})();
