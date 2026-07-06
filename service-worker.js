// Ayli Buchhaltung – Service Worker
// Strategie: App-Dateien "network-first" (immer die neueste Version, wenn online),
// Supabase & andere fremde Domains werden NIE abgefangen.
const CACHE = "ayli-app-v5";
const ASSETS = [
  "./",
  "./index.html",
  "./manifest.json",
  "./icon-192.png",
  "./icon-512.png"
];

self.addEventListener("install", (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(ASSETS)));
  self.skipWaiting();
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

self.addEventListener("fetch", (e) => {
  const url = new URL(e.request.url);

  // Nur eigene App-Dateien behandeln. Alles Fremde (Supabase, CDN) direkt live lassen.
  if (url.origin !== self.location.origin) return;

  // Nur GET-Anfragen cachen
  if (e.request.method !== "GET") return;

  // Network-first: erst Netzwerk (neueste App), bei Offline aus dem Cache
  e.respondWith(
    fetch(e.request)
      .then((res) => {
        const copy = res.clone();
        caches.open(CACHE).then((c) => c.put(e.request, copy)).catch(() => {});
        return res;
      })
      .catch(() => caches.match(e.request))
  );
});
