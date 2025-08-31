import 'package:floor/floor.dart';
import 'package:metro_guide/data/datasources/station_address_view.dart';
import 'package:metro_guide/domain/entities/nearest_street_entity.dart';

@dao
abstract class NearestStreetDao {
  @Query('SELECT * FROM station_address WHERE addressText = :address LIMIT 1')
  Future<StationAddressView?> findByAddress(String address);

  @insert
  Future<int?> insertStreet(NearestStreetEntity address);
}
