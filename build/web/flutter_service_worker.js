'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a51e0ea10d7d47738103cb5395d4d0b0",
"assets/AssetManifest.bin.json": "5a42a0e4af099d2f6c6acdc1e8b87fbb",
"assets/AssetManifest.json": "00b646695081075b973d54d1086ac848",
"assets/assets/2.mp4": "cdb9296e22a8ed45b8764435460c4826",
"assets/assets/3D/audifonos.glb": "c878ec05cfec4b636a29870ba9d075f6",
"assets/assets/3D/audifonos2.glb": "19a63149078cd0c92f9c4ddadbf46009",
"assets/assets/3D/ball.glb": "b9dc7be9768c58a0558c03d9e909a9af",
"assets/assets/3D/bocina.glb": "a6003f67a95b8c0fe0b6b0785006d992",
"assets/assets/3D/cargador.glb": "e2aad8de9ef71218733e04440c181813",
"assets/assets/3D/conector.glb": "209844b6bfbbb43aea06fb6a33f4e129",
"assets/assets/3D/Telefono_barcelona.glb": "52a97ecfdded57d473326b7a73a59e27",
"assets/assets/3D/Telefono_deadpool.glb": "918d9fc191599554974f25935d4c8c6f",
"assets/assets/3D/Telefono_negro.glb": "338aaf57615f1525c6a2900630f2bc3d",
"assets/assets/3D/Telefono_rojo.glb": "cd35a2d277db2f93178fd2527b4e73bd",
"assets/assets/3D/Telefono_rosa.glb": "fd3a9758f3a992fe891ee9f9fdecc5fb",
"assets/assets/3D/Telefono_rudo.glb": "38e0ab48bdaa929facbc2bf312da7336",
"assets/assets/3D/Telefono_skull.glb": "d8aab16631b77696a3c78080c0dc3668",
"assets/assets/3D/USB.glb": "6a179d9e7af5916022966e33a572a6bc",
"assets/assets/audifonos1hora.webp": "1a1a6eb0833994019bf301f91d009e63",
"assets/assets/audifonos3.5samsung.webp": "c4ac277e7c1586d9d2b0e4e9bede5fa1",
"assets/assets/audifonosAirPodsblancos.jpg": "9d2f1af6b0ce1f3018e05d0a9dfc22d3",
"assets/assets/audifonosmoreka.webp": "5abef6d24986fcae4f087611647cf7ad",
"assets/assets/audifonossport.webp": "73d798adb2839bb24bf9bb75515cb839",
"assets/assets/audifonos_sony.jpeg": "6f9103113b3df41f3766b3dca429dfd7",
"assets/assets/banner.png": "22cf474b5e1889a71246c8f6a01dcd17",
"assets/assets/Botones/aqua.png": "9bc95575421a50550a5e3e2bd3d226b6",
"assets/assets/Cable-2-Metros-Lightning-to-USB-1.webp": "6e3cf28645b9d8216c2f7e1db7c00f8b",
"assets/assets/cableusbA.webp": "be1ba27db728f4c91f0b8d4d4fa19bd4",
"assets/assets/cable_c.webp": "a2c0cea9d9bb66c199b5148d07515733",
"assets/assets/carrusel/1.png": "b4c8c51dc9a670e5d618a447b540f8bc",
"assets/assets/carrusel/2.png": "a37a55b09bd8141492e5d983980468b1",
"assets/assets/carrusel/3.png": "814d36ecd5599cca3734343c5f03a5ce",
"assets/assets/carrusel/4.png": "a0a7ae599d7c6dbe3671ec48a473bac0",
"assets/assets/carrusel/5.png": "aa9ff571261080defd126f777651e1db",
"assets/assets/carrusel/6.png": "3deb7a189b42d0a84dc7ff765511b2af",
"assets/assets/Carrusel1.jpg": "4f875bcecb6e05caa6768f4497d0c952",
"assets/assets/Carrusel2.jpg": "4a17dcc2e042e343dabd68f7a79e2f31",
"assets/assets/Carrusel3.jpg": "b33a95481c3f6914aaaf92232fc1d443",
"assets/assets/Carrusel4.jpg": "0fbee1f324fe9127cb70d5175c7cd046",
"assets/assets/Carrusel5.jpg": "9f65bdc47cd6abcb0a8190d45c438d0e",
"assets/assets/Carrusel6.jpg": "3abffdd1c0d701d546434bd6fa592c25",
"assets/assets/cristal_templado.webp": "3dfb30fb25eff494fb68cc0ccaa5de08",
"assets/assets/fonts/Orbitron-Bold.ttf": "446368d913de79c000895e4b91dfb1af",
"assets/assets/fonts/Orbitron-Regular.ttf": "7c062f5378d9bca93937259466fcddc7",
"assets/assets/funda_s21.jpg": "55131e8c31a94ad0098709ad1fa2eb30",
"assets/assets/Gonortech_logotipo.png": "ad92fa7b0aa452b46e5bce017a6adc66",
"assets/assets/jar-loading.gif": "a0a7f99bbe4eb3f98bc9c957d8dd1756",
"assets/assets/Lanzamientos/1.jpg": "3d5f79b2f502f15381f32448e66e3ca5",
"assets/assets/Lanzamientos/2.jpg": "ae547aff6043b0b829569632cf8345b0",
"assets/assets/Lanzamientos/3.jpg": "c2b5b13119502986799296f4a004e2b7",
"assets/assets/Lanzamientos/4.jpg": "42b2a9c4d86ca4f15bfec5a2737cd1a8",
"assets/assets/Lanzamientos/5.jpg": "c15a93b748c7b606f2cf2e5d120ced85",
"assets/assets/Lanzamientos/6.jpg": "b577cdbefc2b5399916d8faf3cde5fa4",
"assets/assets/Lanzamientos/7.jpg": "0f1126ef7185542ce9a536410773b2f4",
"assets/assets/Lanzamientos/8.jpg": "5279fad03eaab5849eaada9b68d6769c",
"assets/assets/logo.jpeg": "fd2ff52fe632e98603e3fa1a127d8275",
"assets/assets/logo.png": "956bdb00a375288deb1370bed1d4ea60",
"assets/assets/logo_blanco.png": "18e738eeea816fc980ad8263b2eafa2f",
"assets/assets/logo_color.png": "6d69a54cbca2bf6ee1dbb8dbc606328d",
"assets/assets/logo_negro.png": "7745b7f373facf5f739e4c48c18b10a3",
"assets/assets/samsuna52rojo.webp": "feaa1183553495c32f7880a4df142ca2",
"assets/assets/samsunga13silicon.jpg": "33201fa07ee7d71e0c4e35b60a7f5b93",
"assets/assets/samsungA35rojo.jpg": "dc46593e63952c1803ec00163e03918a",
"assets/assets/samsunga52.jpeg": "2631af3c89605653e67ba03cef712ee0",
"assets/assets/samsungA55rojo.jpg": "a23a33c0e93c4b06627f27b45bdc7369",
"assets/assets/Tarjetas/audifonos.png": "4eb0b97b80648b718e892b79183ce05f",
"assets/assets/Tarjetas/audifonos1.png": "ea23b1108ed46e48e7224a767d453d78",
"assets/assets/Tarjetas/cables.png": "7d8edc69ce29da0bceb64408a8ead16e",
"assets/assets/Tarjetas/cristal.png": "1dbaccdccf0fe3dffe4dbb9615a97a9f",
"assets/assets/Tarjetas/cristal2.png": "807cbed3e971871667ebc855debb7afd",
"assets/assets/Tarjetas/tarjeta.png": "3a2bf921a97064c711f282c1419d170a",
"assets/assets/Tarjetas/tarjeta1.png": "f318c1671bb93e705f59fa64ac57deda",
"assets/assets/Tarjetas/tarjeta2.png": "a1ae74a3028c9ebd24f0dbb0735788b5",
"assets/assets/tipografia.png": "f9dcaf0a2f586f92e5da6d13548c66a1",
"assets/assets/usb3.1.jpg": "f24f832da37446e7c83ab08838de8c3e",
"assets/assets/usbAnegro.webp": "c179c5199ab609f6580fe433d25bf593",
"assets/assets/usbApple.jpg": "a5235e85b3dfddabe0217f282a69d46f",
"assets/assets/UTT.jpeg": "b3e244f824319cbcaa072a038daec5f4",
"assets/FontManifest.json": "f32d28078bc68bd00fa9b57266967434",
"assets/fonts/MaterialIcons-Regular.otf": "0bf084a216fbb967d9016e065192d162",
"assets/NOTICES": "23e655ad4368f85957c9af371a49f9b8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/model_viewer_plus/assets/model-viewer.min.js": "a9dc98f8bf360be897a0898a7395f905",
"assets/packages/model_viewer_plus/assets/template.html": "8de94ff19fee64be3edffddb412ab63c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "dbfb1ba05b12bb36d95b79ffc2e48ed3",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "e65938a6efe4dde14eb94455ee8a15ee",
"icons/icon-192.png": "234887241d1e0bd71bdee24e2f43f041",
"icons/icon-512.png": "f82e70f85364de236482f29a89d4ea5f",
"icons/Icon-maskable-192.png": "234887241d1e0bd71bdee24e2f43f041",
"icons/Icon-maskable-512.png": "f82e70f85364de236482f29a89d4ea5f",
"icons/index.html": "2c8ab0fdc7bb836dbe1cdd93262aafb3",
"index.html": "47f7c9ad012b070ce69c22dbf33eddbb",
"/": "47f7c9ad012b070ce69c22dbf33eddbb",
"main.dart.js": "637473570ec0aea9db664afe3e06a584",
"manifest.json": "92492cce092eb99130ba269c7b9c2bd8",
"version.json": "9bfdd20d0252948a62ffc366558c6db2"};
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
