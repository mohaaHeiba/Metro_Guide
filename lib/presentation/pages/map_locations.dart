import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:metro_guide/core/services/cached_tile_provider.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

class MapLocations extends StatelessWidget {
  final cont;
  MapLocations({super.key, required this.cont});

  final controll = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: controll.getUserLocation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final center = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: const Text("اختيار الموقع")),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controll.searchController,
                        decoration: const InputDecoration(
                          hintText: "ابحث عن مكان...",
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (query) => controll.searchLocation(query),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => controll.searchLocation(
                        controll.searchController.text,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: controll.mapController,
                      options: MapOptions(center: center, zoom: 14.6),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: 'com.example.metro_guide',
                          tileProvider: CachedTileProvider(),
                        ),
                      ],
                    ),
                    const Center(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final picked = controll.mapController.center;

              try {
                // 1. هات العنوان من الإحداثيات
                final placemarks = await placemarkFromCoordinates(
                  picked.latitude,
                  picked.longitude,
                );
                final place = placemarks.first;
                final address =
                    "${place.street}, ${place.locality}, ${place.country}";

                Get.back();
                // 2. هات أقرب محطة واكتب النتيجة في الـ controller المناسب
                await controll.getNearestStationForPickDown(address, cont);

                // ✨ 3. رجّع البيانات للصفحة اللي قبلها (بعد ما تخلص)
              } catch (e) {
                print(e);
                Get.snackbar(
                  "Error",
                  "Failed to get address: $e",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            label: const Text("تأكيد الموقع"),
            icon: const Icon(Icons.check),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
