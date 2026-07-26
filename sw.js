const CACHE_NAME = 'ersenbox-spiele-v1';
const URLS_TO_CACHE = [
    '/',
    '/index.html',
    '/manifest.json',
    '/assets/images/characters/',
    '/assets/images/backgrounds/',
    '/assets/images/logos/',
    '/assets/images/patterns/'
];

// Install Event
self.addEventListener('install', (event) => {
    console.log('Service Worker: Installing...');
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            console.log('Service Worker: Caching files');
            return cache.addAll(URLS_TO_CACHE).catch((err) => {
                console.log('Cache addAll error:', err);
                return Promise.resolve();
            });
        })
    );
    self.skipWaiting();
});

// Activate Event
self.addEventListener('activate', (event) => {
    console.log('Service Worker: Activating...');
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('Service Worker: Deleting old cache');
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    self.clients.claim();
});

// Fetch Event - Network first, then cache
self.addEventListener('fetch', (event) => {
    const { request } = event;

    // Skip non-GET requests
    if (request.method !== 'GET') {
        return;
    }

    event.respondWith(
        fetch(request)
            .then((response) => {
                // Update cache if we get a response
                if (response && response.status === 200) {
                    const responseClone = response.clone();
                    caches.open(CACHE_NAME).then((cache) => {
                        cache.put(request, responseClone);
                    });
                }
                return response;
            })
            .catch(() => {
                // Fall back to cache on network error
                return caches.match(request).then((response) => {
                    if (response) {
                        return response;
                    }
                    // Return a default offline page if needed
                    if (request.mode === 'navigate') {
                        return caches.match('/index.html');
                    }
                    return new Response('Offline - Content not available', {
                        status: 503,
                        statusText: 'Service Unavailable',
                        headers: new Headers({
                            'Content-Type': 'text/plain'
                        })
                    });
                });
            })
    );
});

// Push Notifications (optional)
self.addEventListener('push', (event) => {
    if (event.data) {
        const options = {
            body: event.data.text(),
            icon: '/assets/images/logos/35-logo-icon-v1.png',
            badge: '/assets/images/logos/35-logo-icon-v1.png'
        };
        event.waitUntil(
            self.registration.showNotification('Ersenbox Spiele', options)
        );
    }
});

console.log('✓ Service Worker loaded');
