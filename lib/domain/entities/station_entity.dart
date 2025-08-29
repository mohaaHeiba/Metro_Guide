import 'package:floor/floor.dart';

@Entity(tableName: 'metro_stations')
class StationEntity {
  @PrimaryKey(autoGenerate: true)
  final int? station_id;

  final String name_ar;
  final String name_en;
  final double latitude;
  final double longitude;
  final String line;
  final int? nearestId;

  StationEntity({
    this.station_id,
    required this.name_ar,
    required this.name_en,
    required this.latitude,
    required this.longitude,
    required this.line,
    this.nearestId,
  });
}
