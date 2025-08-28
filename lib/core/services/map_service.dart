// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:osm_nominatim/osm_nominatim.dart';

// void main() {
//   runApp(PickLocationScreen());
// }

// class PickLocationScreen extends StatefulWidget {
//   @override
//   _PickLocationScreenState createState() => _PickLocationScreenState();
// }

// class _PickLocationScreenState extends State<PickLocationScreen>
//     with OSMMixinObserver {
//   late MapController controller;
//   String? currentAddress;

//   @override
//   void initState() {
//     super.initState();
//     controller = MapController.withUserPosition(
//       trackUserLocation: const UserTrackingOption(
//         enableTracking: true,
//         unFollowUser: false,
//       ),
//     );
//     controller.addObserver(this);
//   }

//   @override
//   Future<void> mapIsReady(bool ready) async {
//     if (ready) {
//       await _updateAddress();
//     }
//   }

//   @override
//   void onRegionChanged(Region region) {
//     _updateAddress();
//   }

//   Future<void> _updateAddress() async {
//     GeoPoint center = await controller.centerMap;
//     try {
//       final nominatim = Nominatim(userAgent: "my_flutter_app/1.0");
//       final address = await nominatim.reverseSearch(
//         lat: center.latitude,
//         lon: center.longitude,
//         nameDetails: true,
//         addressDetails: true,
//       );
//       setState(() {
//         currentAddress = address.displayName;
//       });
//     } catch (_) {
//       setState(() {
//         currentAddress = "تعذر الحصول على العنوان";
//       });
//     }
//   }

//   @override
//   void dispose() {
//     controller.removeObserver(this);
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             OSMFlutter(
//               controller: controller,
//               osmOption: OSMOption(
//                 userTrackingOption: const UserTrackingOption(
//                   enableTracking: true,
//                   unFollowUser: false,
//                 ),
//                 showZoomController: true,
//                 zoomOption: const ZoomOption(
//                   initZoom: 12,
//                   minZoomLevel: 3,
//                   maxZoomLevel: 19,
//                   stepZoom: 1.0,
//                 ),
//               ),
//               onMapIsReady: (isReady) {},
//             ),

//             const Icon(Icons.location_on, color: Colors.red, size: 50),

//             Positioned(
//               bottom: 120,
//               left: 20,
//               right: 20,
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Text(
//                     currentAddress ?? "جاري تحديد الموقع...",
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () async {
//             GeoPoint center = await controller.centerMap;
//             Navigator.pop(context, {
//               "lat": center.latitude,
//               "long": center.longitude,
//               "name": currentAddress ?? "Unknown place",
//             });
//           },
//           icon: const Icon(Icons.check),
//           label: const Text("تأكيد الموقع"),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  LatLng _center = LatLng(30.0444, 31.2357); // default Cairo

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        setState(() {
          _center = LatLng(loc.latitude, loc.longitude);
        });

        // move map to new location
        _mapController.move(_center, 14);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("مكان غير موجود: $query")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("اختيار الموقع")),
        body: Column(
          children: [
            // 🔍 صندوق البحث
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "ابحث عن مكان...",
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: _searchLocation,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _searchLocation(_searchController.text),
                  ),
                ],
              ),
            ),

            // 🗺️ الخريطة
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(center: _center, zoom: 13),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.metro_guide',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _center,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context, {
              "lat": _center.latitude,
              "long": _center.longitude,
            });
          },
          label: const Text("تأكيد الموقع"),
          icon: const Icon(Icons.check),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
