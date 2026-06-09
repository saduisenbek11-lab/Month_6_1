self.addEventListener('message', async (e) => {
  const data = e.data || {};

  if (data && data.type === 'init') {
    try {
      const resp = await fetch('sqlite3.wasm');
      if (!resp.ok) throw new Error('Failed to fetch sqlite3.wasm: ' + resp.status);
      const bytes = await resp.arrayBuffer();
      await WebAssembly.compile(bytes);
      self.postMessage({ type: 'init', success: true });
    } catch (err) {
      self.postMessage({ type: 'init', success: false, error: String(err) });
    }
    return;
  }

  self.postMessage({ type: 'error', error: 'Not implemented in this worker stub' });
});
