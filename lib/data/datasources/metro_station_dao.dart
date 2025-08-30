import 'package:floor/floor.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';

import '../../domain/entities/nearest_street_entity.dart';

@dao
abstract class MetroStationDao {
  @Query(
    "SELECT * from metro_stations",
  )
  Future<List<StationEntity>> getallStation();

  @update
  Future<int> updateStreet(StationEntity address);

  // @Query(
  //   "SELECT name_ar, latitude, longitude, line FROM metro_stations WHERE name_en = :pickUp",
  // )
  // Future<List<StationEntity>> getStationPickUP(String pickUp);

  // @Query(
  //   "SELECT name_ar, latitude, longitude, line FROM metro_stations WHERE name_en = :pickDown",
  // )
  // Future<List<StationEntity>> getStationPickDown(String pickDown);
}
