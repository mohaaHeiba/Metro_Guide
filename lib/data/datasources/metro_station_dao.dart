import 'package:floor/floor.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';

@dao
abstract class MetroStationDao {
  @Query("SELECT DISTINCT name_ar from metro_stations")
  Future<List<String>> getallStationArabic();

  @Query("SELECT DISTINCT name_en from metro_stations")
  Future<List<String>> getallStationEnglish();

  @Query(
    "SELECT name_ar, latitude, longitude, line FROM metro_stations WHERE name_en = :pickUp",
  )
  Future<List<StationEntity>> getAllStationPickUP(String pickUp);

  @Query(
    "SELECT name_ar, latitude, longitude, line FROM metro_stations WHERE name_en = :pickDown",
  )
  Future<List<StationEntity>> getAllStationPickDown(String pickDown);
}
