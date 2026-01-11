'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0767283c5ff647a6f001719a2b667e81",
"assets/AssetManifest.bin.json": "fdbea724042efb6b68dc58e60e914af6",
"assets/assets/icons/analysis.svg": "11148754103f4986084be6ce09ab3cf6",
"assets/assets/icons/autocad.svg": "bd56566e8dd832237cd6fb81edb99a93",
"assets/assets/icons/construction.svg": "0a6cc059bed3532fb41b14ca7ac7d4ea",
"assets/assets/icons/dart.svg": "6242b9dbb9c3ade5e2a9e306bbc01ee4",
"assets/assets/icons/design.svg": "4c56e787dcf99f5800bb81789901e54c",
"assets/assets/icons/email.svg": "3a04d24317be8f5bec9b1b4f623c1069",
"assets/assets/icons/excel.svg": "31f1d0e2e8c5757cf3a9d2e9fd6922f7",
"assets/assets/icons/facebook.svg": "4ad2d159c7ef738e792c7cf28d5453e0",
"assets/assets/icons/flutter.svg": "c987b7cad6362c5c0953b4ad1c10c986",
"assets/assets/icons/git.svg": "e03b271487c4fa671654cc93bd1b5071",
"assets/assets/icons/github.svg": "afbd767f0e0984066e16b3ffeaeba6d7",
"assets/assets/icons/instagram.svg": "1fb63086db80121fcaa5483e8d71b800",
"assets/assets/icons/linkedin.svg": "0f26faba333b1fabd8a35c413e005541",
"assets/assets/icons/location.svg": "db51639117c40d1f87431b2beeef9d99",
"assets/assets/icons/phone.svg": "219111f07828c8257fe9031d9a7ebaa6",
"assets/assets/icons/python.svg": "42c60821f14b45934d039db9c5984ca9",
"assets/assets/icons/revit.svg": "4011a3aa798805013da923ae55b101db",
"assets/assets/icons/structural.svg": "bf5001177327c365873382c0cabf6f8e",
"assets/assets/icons/twitter.svg": "16d0b4a057b6a7683cc838c34735fd06",
"assets/assets/icons/whatsapp.svg": "a43a0c48aa86f84f3360e75fda22e24f",
"assets/assets/image.png": "7220fc585101e76b47f0f46ce5ba63f4",
"assets/assets/images/backgrounds/blob.svg": "36bd3dd4b74b4a493d0f1da88340d709",
"assets/assets/images/backgrounds/blueprint.svg": "c14c1957986ffea32ee10d331f57b2b0",
"assets/assets/images/backgrounds/construction_fun.svg": "0bc9b64f68b436e092df18b47b041896",
"assets/assets/images/backgrounds/construction_site.svg": "b43682626b0a06993fb7393e8bca76e9",
"assets/assets/images/backgrounds/geometric_1.svg": "e5bbdf7f54495acc0df39632b07faa88",
"assets/assets/images/backgrounds/grid.svg": "8ca89aeea9f0389bb5080f7f76998113",
"assets/assets/images/backgrounds/smart_city.svg": "de04e979b569134c843913e08d5a805b",
"assets/assets/images/backgrounds/wave.svg": "c1356e2b931a1835fe8f1b83f096f6d9",
"assets/assets/images/decorations/floating_circles.svg": "bcfbcdbe5d8960c0e53d01d479798158",
"assets/assets/images/decorations/shapes.svg": "a909475c4e995a739cb495f27d1a8995",
"assets/assets/images/decorations/waves.svg": "6128c8721c29a6bbc4dddfdd7e69b518",
"assets/assets/images/illustrations/engineering.svg": "1ec38b3eb8a32bfd675eedf1af594f36",
"assets/assets/images/illustrations/innovation.svg": "a84e5dc88f2b6ffb77c9589897b7388c",
"assets/assets/images/illustrations/success.svg": "38448e93c47ce3f89bf7a05c56918fa8",
"assets/assets/images/illustrations/teamwork.svg": "56ee554c4a872d6176304248340da657",
"assets/assets/images/logo.svg": "588d72609d844f6e2d623e34cf8a304c",
"assets/assets/images/nepal_flag.svg": "7172e1725a2d39758e3bf8f7b9a5c8a1",
"assets/assets/images/patterns/dots.svg": "8833425009fefb0aa96f28e4b619c687",
"assets/assets/images/patterns/grid.svg": "0d01e4f9192239808ca5440530757aab",
"assets/assets/images/patterns/hexagon.svg": "95f266284f39d01d30f94b9e82f50864",
"assets/assets/images/patterns/lines.svg": "679298484827ee77ef2cf9acb15afdcd",
"assets/assets/images/profile.svg": "05eb647180496846cc1a5ce7234b3550",
"assets/FontManifest.json": "aed2b02323ee1c15e32a18f07088b8e3",
"assets/fonts/MaterialIcons-Regular.otf": "826295be8435042eb74bdc76bc56b25d",
"assets/NOTICES": "5794d2f79235943c775aaf394711abe3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "6ebc7bc5b74956596611c6774d8beb5b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "b2cb32bd6c032989a011d1e6382c8331",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "01f11cafb891f313450dfd34d50448c9",
"/": "01f11cafb891f313450dfd34d50448c9",
"main.dart.js": "cdbf9bf617cf585fc733e6e6d28615de",
"manifest.json": "c076c323f5dfd6e93d7de6fd9bda7e1c",
"version.json": "7e2791b948e108a4438c33c417cddf7a"};
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
