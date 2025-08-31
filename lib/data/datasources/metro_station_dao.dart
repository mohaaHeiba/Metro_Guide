import 'package:floor/floor.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';

@dao
abstract class MetroStationDao {
  @Query("SELECT * from metro_stations")
  Future<List<StationEntity>> getallStation();

  @update
  Future<int> updateStreet(StationEntity address);
}
