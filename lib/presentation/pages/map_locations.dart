import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:metro_guide/core/services/cached_tile_provider.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';

class MapLocations extends StatelessWidget {
  final cont;
  MapLocations({super.key, required this.cont});

  final controll = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: controll.getUserLocation(false),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final center = snapshot.data!;
        return Scaffold(
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
              try {
                final address =controll.searchController.text;

                Get.back();
                await controll.getNearestStationForPickDown(address, cont);
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
            label: Text(S.of(context).select_location),
            icon: const Icon(Icons.check),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
