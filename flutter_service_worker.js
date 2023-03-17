'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "74665d3d3a032e94688bf9383ae84b69",
"assets/assets/fonts/RobotoMono-Regular.ttf": "e5ca8c0ac474df46fe45840707a0c483",
"assets/assets/icons/dark.png": "45443840041ea3ca99cec3e9963ff668",
"assets/assets/icons/dart.png": "2e0719b33b5cdd1ece46611b4d3d4a81",
"assets/assets/icons/firebase.png": "cf0918b3d77d6e4505a65f103e5f3382",
"assets/assets/icons/flutter.png": "23ded1e93189e77c12bda66ca4274d08",
"assets/assets/icons/git.png": "5f551c335eb3dc4b81ae34cf93b9a7f1",
"assets/assets/icons/github.png": "33cd9e042cd4dea449593a75bc0749d7",
"assets/assets/icons/github_2.png": "d601556f552f0366969c8f21495e9e78",
"assets/assets/icons/github_black.png": "9c24687a6322470c692b9ea4b7f34f6d",
"assets/assets/icons/github_white.png": "dc53ac25eba1f479e1dba894d298be06",
"assets/assets/icons/instagram_black.png": "f2f4e6538f8ab25e004fa752aa3366f8",
"assets/assets/icons/instagram_white.png": "28c24c383926f74b4b8f52445b8f8500",
"assets/assets/icons/linkedin.png": "69e40c129dc5d9f27e4ccd9f263affd4",
"assets/assets/icons/linkedin_black.png": "3fb9953ab705fd4b9cbf8d1fe8486c55",
"assets/assets/icons/linkedin_white.png": "aaa2ad6032dea586ed8f4586d8a31ddb",
"assets/assets/icons/twitter.png": "2ffa00ef31b5a897e7bb34f1282594c6",
"assets/assets/icons/twitter_black.png": "0ec939dbbfcf65bd510f877c92fd4780",
"assets/assets/icons/twitter_white.png": "1913c5e57aafc3af5d7b48f1b6201845",
"assets/assets/icons/ui-ux.png": "b501162ba2f6a65b1e95edd618332aca",
"assets/assets/images/bg.jpg": "56076d9727100984547b0fbc7b88122a",
"assets/assets/images/bg.png": "0e21ea9b75e0c9af77471580527612c9",
"assets/assets/images/bg_rev.png": "dcffd475f1b133d7561409145f474ad0",
"assets/assets/images/portfolio.png": "da7df5423244b1ba0ea02d822d3795c1",
"assets/assets/images/portfolio_light.png": "37eac72c47853d2c8f12ea3d0556ff3a",
"assets/assets/images/profile%2520picture.jpg": "017056ee7a5cee5110a1cd5345e728ca",
"assets/assets/images/profile.png": "d94f47bee1a608bdda1c847c49b33261",
"assets/assets/images/profile_dark.png": "19666004f725b9f024ac46acdf823c64",
"assets/assets/images/profile_light.png": "0d60db0bc1a1095ae3ac425f57bcbb5b",
"assets/FontManifest.json": "25a6999077830f949d3a2e504f5a64a9",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "e40d63ea08b6ffe6c96201bd02500830",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"icons/android-chrome-192x192.png": "37ac33f424aad680ce99c1885359dfc9",
"icons/android-chrome-512x512.png": "0da3c5fd33e33341a339acad268f0ead",
"icons/apple-touch-icon.png": "95d6457c5260ac2c4937106e706f1675",
"index.html": "e361efa2337d7ebde581911828af9836",
"/": "e361efa2337d7ebde581911828af9836",
"logo.png": "0da3c5fd33e33341a339acad268f0ead",
"main.dart.js": "d178c0937dc4c913ef5a8f7ae6142853",
"manifest.json": "89eb8fdeecca4524c584943c019e6280",
"version.json": "009c9e65172e010890f7f65fde438006"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
