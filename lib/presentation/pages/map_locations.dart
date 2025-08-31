import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:metro_guide/core/services/cached_tile_provider.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/widgets/custom_widgets/snackbar_widget.dart';

class MapLocations extends StatelessWidget {
  final TextEditingController? cont;
  MapLocations({super.key, required this.cont});

  final controll = Get.find<HomeController>();

  Future<LatLng> _getCenter() async {
    var center = await controll.getUserLocation(false);

    if (cont != null && cont!.text.isNotEmpty) {
      // First try to find the station directly by name (more reliable)
      final station = await controll.getStationByName(cont!.text);
      if (station != null && station.latitude != null && station.longitude != null) {
        center = LatLng(station.latitude!, station.longitude!);
        print("station found by name: ${station.name_en} at ${station.latitude}, ${station.longitude}");
      } else {
        // Fallback to geocoding if station not found by name
        final position = await controll.getCoordinatesFromAddress(cont!.text);
        if (position != null) {
          final nearestStation = await controll.getNearestStationByLatLng(
            LatLng(position.latitude, position.longitude),
          );
          if (nearestStation != null) {
            center = LatLng(nearestStation.latitude!, nearestStation.longitude!);
            print("nearest station found by geocoding: ${nearestStation.name_en} at ${nearestStation.latitude}, ${nearestStation.longitude}");
          } else {
            print("no station found for '${cont!.text}'");
          }
        }
      }
    }

    // أول قيمة للـ Pin
    controll.selectedLatLng.value = center;
    return center;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: _getCenter(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final center = snapshot.data!;

        // استخدام WillPopScope لمسح البحث عند الرجوع
        return WillPopScope(
          onWillPop: () async {
            controll.searchController.clear();
            return true; // يسمح بالرجوع
          },
          child: Scaffold(
            appBar: AppBar(title: Text(S.of(context).select_location)),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controll.searchController,
                          decoration: InputDecoration(
                            hintText: S.of(context).search_location,
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (query) =>
                              controll.searchLocation(query),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => controll.searchLocation(
                          controll.searchController.text.toLowerCase(),
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
                        options: MapOptions(
                          center: center,
                          zoom: 14.6,
                          onPositionChanged: (pos, _) {
                            controll.selectedLatLng.value = pos.center;
                          },
                        ),
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
                try {
                  final latLng = controll.selectedLatLng.value;
                  if (latLng == null) {
                    Get.snackbar(
                      "Error",
                      "No location selected",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  final nearestStation = await controll
                      .getNearestStationByLatLng(latLng);

                  if (nearestStation != null && cont != null) {
                    // Always return the station name in lowercase
                    cont!.text = (controll.isArabic
                        ? (nearestStation.name_ar ?? nearestStation.name_en ?? "")
                        : (nearestStation.name_en ?? nearestStation.name_ar ?? ""))
                        .toLowerCase();
                  }

                  controll.searchController.clear();

                  Get.back();

                  if (nearestStation != null) {
                    showSnackBar(
                      S.of(Get.context!).nearest_station_cached,
                      S.of(Get.context!).you_are_near(cont!.text),
                      Colors.green,
                    );
                  }
                } catch (e) {
                  print(e);
                  Get.snackbar(
                    "Error",
                    "Failed: $e",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              label: Text(S.of(context).select_location),
              icon: const Icon(Icons.check),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }
}
