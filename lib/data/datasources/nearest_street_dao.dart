import 'package:floor/floor.dart';
import 'package:metro_guide/data/datasources/station_address_view.dart';
import 'package:metro_guide/domain/entities/nearest_street_entity.dart';

@dao
abstract class NearestStreetDao {
  @Query('SELECT * FROM station_address WHERE addressText = :address LIMIT 1')
  Future<StationAddressView?> findByAddress(String address);

  @Query(
    'SELECT * FROM addressNearestStation WHERE addressText = :address LIMIT 1',
  )
  Future<NearestStreetEntity?> findBddress(String address);

  @Query('SELECT * FROM station_address')
  Future<List<StationAddressView>> getAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertNearestStreet(NearestStreetEntity entity);
}
