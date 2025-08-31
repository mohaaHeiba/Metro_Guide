import 'package:geolocator/geolocator.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';

class FindNearestStation {
  final double latitude;
  final double longitude;

  FindNearestStation({required this.latitude, required this.longitude});

  StationEntity findNearestStation(List<StationEntity> stations) {
    StationEntity nearestStation = stations.first;
    double shortestDistance = double.infinity;

    for (final station in stations) {
      if (station.latitude != null && station.longitude != null) {
        final distance = Geolocator.distanceBetween(
          latitude,
          longitude,
          station.latitude,
          station.longitude,
        );

        if (distance < shortestDistance) {
          shortestDistance = distance;
          nearestStation = station;
        }
      }
    }
    return nearestStation;
  }
}
