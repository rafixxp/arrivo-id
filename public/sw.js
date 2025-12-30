const CACHE_NAME = 'attendance-pwa-v2';
const OFFLINE_URL = '/offline.html';

// Asset wajib agar install prompt muncul sebagai aplikasi
const PRECACHE_ASSETS = [
    '/manifest.json',
    '/icons/icon-192x192.webp',
    '/icons/icon-512x512.webp',
    '/offline.html',
    '/favicon.ico',
    '/img/nopic.jpg',
    // Tambahkan file utama JS/CSS jika perlu, contoh:
    // '/resources/js/app.js',
    // '/resources/css/app.css',
    'https://fonts.googleapis.com/css2?family=Inter:ital,wght@0,100..900;1,100..900&display=swap',
];

// INSTALL
self.addEventListener('install', event => {
    self.skipWaiting();
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => cache.addAll(PRECACHE_ASSETS))
    );
});

// ACTIVATE
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(keys =>
            Promise.all(
                keys.map(key => {
                    if (key !== CACHE_NAME) {
                        return caches.delete(key);
                    }
                })
            )
        )
    );
    self.clients.claim();
});

// FETCH
self.addEventListener('fetch', event => {
    if (event.request.method !== 'GET') return;
    const url = new URL(event.request.url);

    // Cache only same-origin requests (except font)
    if (url.origin === location.origin || url.hostname.includes('fonts.googleapis.com')) {
        event.respondWith(
            caches.match(event.request)
                .then(cachedRes => {
                    if (cachedRes) return cachedRes;
                    return fetch(event.request)
                        .then(response => {
                            if (response && response.status === 200 && response.type === 'basic') {
                                const responseClone = response.clone();
                                caches.open(CACHE_NAME)
                                    .then(cache => cache.put(event.request, responseClone));
                            }
                            return response;
                        })
                        .catch(() => caches.match(OFFLINE_URL));
                })
        );
    }
});
