'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e3bc0b4d2a6d90d8982b1ad492779f4c",
"assets/AssetManifest.bin.json": "56e158ec3f84651854344325fcedbed2",
"assets/AssetManifest.json": "e991dfdb770259fdc405e8721047baa9",
"assets/assets/cards/back-0062ff.png": "391284c9c0820659efa81ccbfd20ac3b",
"assets/assets/cards/back-aqua.png": "0114855db7d7e41d860151b4b3d9163e",
"assets/assets/cards/back-black.png": "7c932588a6cda577e09fa2dcc95b27e2",
"assets/assets/cards/back-blue.png": "b20381cf829dec7c25186c1281a86125",
"assets/assets/cards/back-fuchsia.png": "9bb9f391ae43338471592da3bbfedbed",
"assets/assets/cards/back-gray.png": "2b175acc883f12f480c0dc83057fb6d6",
"assets/assets/cards/back-green.png": "ba74b9d98620079ea1be9caec93e2541",
"assets/assets/cards/back-lime.png": "740d6a6fbdfcc8efd1295eb7bb435b4c",
"assets/assets/cards/back-maroon.png": "df5c1de54b746fcfd362b9455e5411ad",
"assets/assets/cards/back-navy.png": "d1bfa1f30fdb464fe1e74049a8999ffb",
"assets/assets/cards/back-olive.png": "ffba779b1f0fe0dfc0efa77c2532ba4d",
"assets/assets/cards/back-purple.png": "6e40beb68501173f3f9e8d03acac7677",
"assets/assets/cards/back-red.png": "38baf66007d028980cbe2b60f96a9c9c",
"assets/assets/cards/back-silver.png": "48de27a985805169d52e2c38837ad0c0",
"assets/assets/cards/back-teal.png": "0d71504be87bffb5ccdecf9cdb78d596",
"assets/assets/cards/back-yellow.png": "7a18a327bbe93cda5962631462a5f314",
"assets/assets/cards/back.png": "391284c9c0820659efa81ccbfd20ac3b",
"assets/assets/cards/card-base.png": "fe1426deab9b0f74676f6f5286bdc12b",
"assets/assets/cards/club_1.png": "2becf8a5fdda199b1c0b1881331fda08",
"assets/assets/cards/club_10.png": "a28aad8de41e2878d57f20505f12315b",
"assets/assets/cards/club_2.png": "95764648526022d9af06a9c3c79ac552",
"assets/assets/cards/club_3.png": "ee3e1908cf8e41b741639560844a46fb",
"assets/assets/cards/club_4.png": "63ab8810baa4c5366b77a36c50de016b",
"assets/assets/cards/club_5.png": "32a4fdfc13fd47329ff5dcaa4eba5022",
"assets/assets/cards/club_6.png": "3d36c6b1b7070cd5b8089f35eb50f53f",
"assets/assets/cards/club_7.png": "7b7d5a4f7a6a4a890071bae63dadb250",
"assets/assets/cards/club_8.png": "514db1680a2afbc01f8d408c9a236a08",
"assets/assets/cards/club_9.png": "c1baea8cbe9eb3259f9cca7b02340edf",
"assets/assets/cards/club_jack.png": "88bb648678f3bcc26486c59bd744315f",
"assets/assets/cards/club_king.png": "f01d934cdfbfe5ac0571d37223ef0058",
"assets/assets/cards/club_queen.png": "1894823cd28a4666f2cc10a37c907d83",
"assets/assets/cards/diamond_1.png": "264f9dfff1628fd4731a3b2d565809ea",
"assets/assets/cards/diamond_10.png": "62c95b9e0615bf4e4b20cc1d90e84dab",
"assets/assets/cards/diamond_2.png": "23a021d2c93f46f564fa710f3378a14d",
"assets/assets/cards/diamond_3.png": "48c1e5a6f58c23abcd97eed07804d0ba",
"assets/assets/cards/diamond_4.png": "7d8ff9343162e2643eed5400931213f1",
"assets/assets/cards/diamond_5.png": "fc31d671a7199b7b239bdb375966551c",
"assets/assets/cards/diamond_6.png": "b083f51f90786a116dde8820271e57e8",
"assets/assets/cards/diamond_7.png": "e5543b6cdf6e3a4cb387d41f7849b864",
"assets/assets/cards/diamond_8.png": "c8115358377cb506f038663985cd93a5",
"assets/assets/cards/diamond_9.png": "38471b0e4cb739ab23d9a4e5a37d5ae0",
"assets/assets/cards/diamond_jack.png": "73517c7395f276e676e367c429da9582",
"assets/assets/cards/diamond_king.png": "db5593549bef0e20604534f590c5051e",
"assets/assets/cards/diamond_queen.png": "096aa80142595c024933e2e2fadb5a0a",
"assets/assets/cards/heart_1.png": "8370ad332d094e406af4fb5b2649d500",
"assets/assets/cards/heart_10.png": "36c1feee4985545850ceb385f5849d82",
"assets/assets/cards/heart_2.png": "5a68cae99d74964bae04c8c80e7e9de8",
"assets/assets/cards/heart_3.png": "b485259f360a19a9e99e4cb5a822e1ae",
"assets/assets/cards/heart_4.png": "84f532ec84fb85d53e6e4e7acd6ed012",
"assets/assets/cards/heart_5.png": "9fdd7676dbdba52f7c216ef9d20fe9ef",
"assets/assets/cards/heart_6.png": "18b155b42445145a1e26d94f8d0bca42",
"assets/assets/cards/heart_7.png": "d2da820d133b26476f984456922f2ca1",
"assets/assets/cards/heart_8.png": "58dae3b28076da80f93b62593996d5bc",
"assets/assets/cards/heart_9.png": "8764df60b36ecf14e598d217c8ccdddd",
"assets/assets/cards/heart_jack.png": "6a62f2d65c7d0bcb7ca667734255b6a0",
"assets/assets/cards/heart_king.png": "243ea01acfe4948dbceb94aee738aa45",
"assets/assets/cards/heart_queen.png": "9c70d6107c9c60be62c7c88fa42351a7",
"assets/assets/cards/joker_black.png": "a7be2251351659d080287eaa326a6dbf",
"assets/assets/cards/joker_red.png": "a27d6a70eb8f87ac974896205eb6368b",
"assets/assets/cards/spade_1.png": "41fdabde80ca2bd8a9db5dd1b25738cc",
"assets/assets/cards/spade_10.png": "93c334e63a05fe7467aab9a567e249c8",
"assets/assets/cards/spade_2.png": "79a9c65e39380a447f0ac0740d2f8fc7",
"assets/assets/cards/spade_3.png": "1991002480018d6ec4d7da37f0280972",
"assets/assets/cards/spade_4.png": "1fe8606679e93e499900c0eeb01a6feb",
"assets/assets/cards/spade_5.png": "922ee96d8dee2d1aeefeb59ee178f439",
"assets/assets/cards/spade_6.png": "c5f3610ca2084661190751cee4031ac0",
"assets/assets/cards/spade_7.png": "a922be868c1c03cdf2c8ac95a16b141c",
"assets/assets/cards/spade_8.png": "bbea500587ab1afe4c1d73cc9da51c48",
"assets/assets/cards/spade_9.png": "36bfdbcb2dd7b25160cf4d94aa274e4a",
"assets/assets/cards/spade_jack.png": "ebdbb0d209c414ddefaa8cc31f5c5f4d",
"assets/assets/cards/spade_king.png": "a0e338f18c2382ce9be15c4dba89b026",
"assets/assets/cards/spade_queen.png": "b1c72d8beda116cc82b256334c5f83cc",
"assets/assets/cards/suit-club.png": "14255b9d378515f32921a9e21a038b30",
"assets/assets/cards/suit-diamond.png": "76c4452015feccced1afa6a17e7b04ae",
"assets/assets/cards/suit-heart.png": "2f90ed08f74c5e023f9cb7e56978b962",
"assets/assets/cards/suit-spade.png": "9df2527babd14ea541409724462679b9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "eaf489b6b082e87a36f733f728deff64",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "0e8cb4e578b8377acd3529359cb41478",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d21b1a4134310fc45e611c190ddb0693",
"/": "d21b1a4134310fc45e611c190ddb0693",
"main.dart.js": "b5bfc15251019a97f3c5488d5a498095",
"manifest.json": "c2575b5caea2499fe6c0f1f4e7899e69",
"version.json": "d7b202dd0096b7576f2ee6bc681703ca"};
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
