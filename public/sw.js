const CACHE_NAME = 'attendance-pwa-v4'
const OFFLINE_URL = '/offline'

const PRECACHE_ASSETS = [
    '/',
    '/offline',
    '/manifest.json',
    '/favicon.ico',
    '/img/nopic.jpg',
    '/icons/icon-192x192.webp',
    '/icons/icon-512x512.webp',
]

// INSTALL
self.addEventListener('install', event => {
    self.skipWaiting()
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => cache.addAll(PRECACHE_ASSETS))
    )
})

// ACTIVATE
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(keys =>
            Promise.all(
                keys
                    .filter(key => key !== CACHE_NAME)
                    .map(key => caches.delete(key))
            )
        )
    )
    self.clients.claim()
})

// FETCH
self.addEventListener('fetch', event => {
    const { request } = event

    // ❌ non-GET jangan di-handle
    if (request.method !== 'GET') return

    const url = new URL(request.url)

    // ❌ API jangan di-cache
    if (url.pathname.startsWith('/api')) {
        return
    }

    // ✅ SPA navigation fallback
    if (request.mode === 'navigate') {
        event.respondWith(
            fetch(request)
                .catch(() => caches.match(OFFLINE_URL))
        )
        return
    }

    // ✅ asset cache-first
    event.respondWith(
        caches.match(request).then(cached => {
            if (cached) return cached

            return fetch(request)
                .then(response => {
                    if (
                        response &&
                        response.status === 200 &&
                        response.type === 'basic'
                    ) {
                        const clone = response.clone()
                        caches.open(CACHE_NAME)
                            .then(cache => cache.put(request, clone))
                    }
                    return response
                })
                .catch(() => caches.match(OFFLINE_URL))
        })
    )
})
