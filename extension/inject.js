(() => {
  const scriptId = "twitchadsblocker-vaft";
  const api = globalThis.browser ?? globalThis.chrome;
  if (!api?.runtime?.getURL) {
    return;
  }

  const inject = () => {
    if (document.getElementById(scriptId)) {
      return;
    }
    const script = document.createElement("script");
    script.id = scriptId;
    script.src = api.runtime.getURL("injected/vaft.js");
    script.async = false;
    (document.head || document.documentElement).appendChild(script);
  };

  const getEnabled = () =>
    new Promise((resolve) => {
      try {
        const maybePromise = api.storage.local.get({ enabled: true }, (items) => {
          if (api.runtime?.lastError) {
            resolve(true);
            return;
          }
          resolve(items?.enabled !== false);
        });
        if (maybePromise && typeof maybePromise.then === "function") {
          maybePromise
            .then((items) => resolve(items?.enabled !== false))
            .catch(() => resolve(true));
        }
      } catch {
        resolve(true);
      }
    });

  getEnabled().then((enabled) => {
    if (enabled) {
      inject();
    }
  });
})();
