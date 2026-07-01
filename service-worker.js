// Ayli Buchhaltung – Service Worker (einfaches Offline-Caching der App-Hülle)
const CACHE = "ayli-app-v4";
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

// App-Dateien aus dem Cache, alles andere (z. B. Supabase) direkt aus dem Netz
self.addEventListener("fetch", (e) => {
  const url = new URL(e.request.url);
  const sameOrigin = url.origin === self.location.origin;
  if (sameOrigin) {
    e.respondWith(
      caches.match(e.request).then((cached) => cached || fetch(e.request))
    );
  }
  // Supabase & CDN: nicht abfangen, immer live
});
