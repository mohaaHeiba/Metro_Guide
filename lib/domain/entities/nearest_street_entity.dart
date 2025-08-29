import 'package:floor/floor.dart';

@Entity(tableName: "addressNearestStation")
class NearestStreetEntity {
  @PrimaryKey(autoGenerate: true)
  final int? nearestId;

  final String addressText;

  NearestStreetEntity({this.nearestId, required this.addressText});
}
