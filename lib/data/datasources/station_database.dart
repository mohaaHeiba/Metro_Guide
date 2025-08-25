import 'package:floor/floor.dart';
import 'dart:async';
import 'package:metro_guide/data/datasources/metro_station_dao.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'station_database.g.dart';

@Database(version: 1, entities: [StationEntity])
abstract class StationDatabase extends FloorDatabase {
  MetroStationDao get metrostationdao;
}
