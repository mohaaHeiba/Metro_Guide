import 'package:floor/floor.dart';

@DatabaseView(
  'select name_ar, name_en, addressText FROM metro_stations INNER JOIN addressNearestStation on metro_stations.nearestId=addressNearestStation.nearestId',
  viewName: 'station_address',
)
class StationAddressView {
  final String ?name_ar, name_en, addressText;

  StationAddressView({
    required this.name_ar,
    required this.name_en,
    required this.addressText,
  });
}
