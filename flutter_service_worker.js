'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f4ce5bb7ef08c4ec026d7f7f0b78f708",
"version.json": "009c9e65172e010890f7f65fde438006",
"index.html": "2ca23806125383c6bafd0f599e7acc89",
"/": "2ca23806125383c6bafd0f599e7acc89",
"main.dart.js": "65e2a6378659d7b1d2972c4d630382a9",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"logo.png": "0da3c5fd33e33341a339acad268f0ead",
"icons/android-chrome-192x192.png": "37ac33f424aad680ce99c1885359dfc9",
"icons/apple-touch-icon.png": "95d6457c5260ac2c4937106e706f1675",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/android-chrome-512x512.png": "0da3c5fd33e33341a339acad268f0ead",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d40c47d1c161f94dbcb13094d37f1f55",
"assets/AssetManifest.json": "99dd5a96b382fd4d5d4361595201123f",
"assets/NOTICES": "7b4c1c3a8c7e3505f6ed7c871c13c3d7",
"assets/FontManifest.json": "5113da4751e4e2f4bf56b5daf9f903c6",
"assets/AssetManifest.bin.json": "32323ae2bc5ec92c1ceed6d9c3071725",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "9ed2d0e326da283503e31230be87c3d7",
"assets/fonts/MaterialIcons-Regular.otf": "7569b52033c776ad4668f3aff1733245",
"assets/assets/images/farmops.webp": "85d03f9c043157e6013ef85fa05718f5",
"assets/assets/images/gdg_siliguri.webp": "330dd93b4d90a6016be9563db922baa7",
"assets/assets/images/profile.jpeg": "2e51e5858ac043ca90b7146ec583de77",
"assets/assets/images/xpense.webp": "02ce1f46318d2a19ff3f22992062c983",
"assets/assets/icons/git.png": "5f551c335eb3dc4b81ae34cf93b9a7f1",
"assets/assets/icons/instagram_white.png": "28c24c383926f74b4b8f52445b8f8500",
"assets/assets/icons/dark.png": "45443840041ea3ca99cec3e9963ff668",
"assets/assets/icons/linkedin_white.png": "aaa2ad6032dea586ed8f4586d8a31ddb",
"assets/assets/icons/twitter_black.png": "0ec939dbbfcf65bd510f877c92fd4780",
"assets/assets/icons/flutter.png": "23ded1e93189e77c12bda66ca4274d08",
"assets/assets/icons/github.png": "33cd9e042cd4dea449593a75bc0749d7",
"assets/assets/icons/firebase.png": "cf0918b3d77d6e4505a65f103e5f3382",
"assets/assets/icons/github_2.png": "d601556f552f0366969c8f21495e9e78",
"assets/assets/icons/github_white.png": "dc53ac25eba1f479e1dba894d298be06",
"assets/assets/icons/instagram_black.png": "f2f4e6538f8ab25e004fa752aa3366f8",
"assets/assets/icons/twitter.png": "2ffa00ef31b5a897e7bb34f1282594c6",
"assets/assets/icons/linkedin.png": "69e40c129dc5d9f27e4ccd9f263affd4",
"assets/assets/icons/twitter_white.png": "1913c5e57aafc3af5d7b48f1b6201845",
"assets/assets/icons/linkedin_black.png": "3fb9953ab705fd4b9cbf8d1fe8486c55",
"assets/assets/icons/github_black.png": "9c24687a6322470c692b9ea4b7f34f6d",
"assets/assets/icons/dart.png": "2e0719b33b5cdd1ece46611b4d3d4a81",
"assets/assets/icons/ui-ux.png": "b501162ba2f6a65b1e95edd618332aca",
"assets/assets/fonts/Manrope-Medium.ttf": "de7b3026c153d63d5732582887fecbf4",
"assets/assets/fonts/Manrope-SemiBold.ttf": "80cb1b1a8ba262608706cb7f2b017835",
"assets/assets/fonts/Manrope-Regular.ttf": "8ca1a84037fdb644723129315c390ad9",
"assets/assets/fonts/Manrope-Light.ttf": "7c8bdfd65f2d0d081069e438f953359f",
"assets/assets/animations/developer.json": "b6a331a54f98cd1745bd6a91a2541a48",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
