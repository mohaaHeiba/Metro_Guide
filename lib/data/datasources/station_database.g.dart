// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $StationDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $StationDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $StationDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<StationDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorStationDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $StationDatabaseBuilderContract databaseBuilder(String name) =>
      _$StationDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $StationDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$StationDatabaseBuilder(null);
}

class _$StationDatabaseBuilder implements $StationDatabaseBuilderContract {
  _$StationDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $StationDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $StationDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<StationDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$StationDatabase();
    database.database = await database.open(path, _migrations, _callback);
    return database;
  }
}

class _$StationDatabase extends StationDatabase {
  _$StationDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MetroStationDao? _metrostationdaoInstance;

  NearestStreetDao? _neareststreetdaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
          database,
          startVersion,
          endVersion,
          migrations,
        );

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `metro_stations` (`station_id` INTEGER PRIMARY KEY AUTOINCREMENT, `name_ar` TEXT NOT NULL, `name_en` TEXT NOT NULL, `latitude` REAL NOT NULL, `longitude` REAL NOT NULL, `line` TEXT NOT NULL, `nearestId` INTEGER)',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `addressNearestStation` (`nearestId` INTEGER PRIMARY KEY AUTOINCREMENT, `addressText` TEXT NOT NULL)',
        );

        await database.execute(
          'CREATE VIEW IF NOT EXISTS `station_address` AS select name_ar, name_en, addressText FROM metro_stations INNER JOIN addressNearestStation on metro_stations.nearestId=addressNearestStation.nearestId',
        );

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MetroStationDao get metrostationdao {
    return _metrostationdaoInstance ??= _$MetroStationDao(
      database,
      changeListener,
    );
  }

  @override
  NearestStreetDao get neareststreetdao {
    return _neareststreetdaoInstance ??= _$NearestStreetDao(
      database,
      changeListener,
    );
  }
}

class _$MetroStationDao extends MetroStationDao {
  _$MetroStationDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _stationEntityUpdateAdapter = UpdateAdapter(
        database,
        'metro_stations',
        ['station_id'],
        (StationEntity item) => <String, Object?>{
          'station_id': item.station_id,
          'name_ar': item.name_ar,
          'name_en': item.name_en,
          'latitude': item.latitude,
          'longitude': item.longitude,
          'line': item.line,
          'nearestId': item.nearestId,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<StationEntity> _stationEntityUpdateAdapter;

  @override
  Future<List<StationEntity>> getallStation() async {
    return _queryAdapter.queryList(
      'SELECT * from metro_stations',
      mapper: (Map<String, Object?> row) => StationEntity(
        station_id: row['station_id'] as int?,
        name_ar: row['name_ar'] as String,
        name_en: row['name_en'] as String,
        latitude: row['latitude'] as double,
        longitude: row['longitude'] as double,
        line: row['line'] as String,
        nearestId: row['nearestId'] as int?,
      ),
    );
  }

  @override
  Future<int> updateStreet(StationEntity address) {
    return _stationEntityUpdateAdapter.updateAndReturnChangedRows(
      address,
      OnConflictStrategy.abort,
    );
  }
}

class _$NearestStreetDao extends NearestStreetDao {
  _$NearestStreetDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _nearestStreetEntityInsertionAdapter = InsertionAdapter(
        database,
        'addressNearestStation',
        (NearestStreetEntity item) => <String, Object?>{
          'nearestId': item.nearestId,
          'addressText': item.addressText,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NearestStreetEntity>
  _nearestStreetEntityInsertionAdapter;

  @override
  Future<StationAddressView?> findByAddress(String address) async {
    return _queryAdapter.query(
      'SELECT * FROM station_address WHERE addressText = ?1 LIMIT 1',
      mapper: (Map<String, Object?> row) => StationAddressView(
        name_ar: row['name_ar'] as String?,
        name_en: row['name_en'] as String?,
        addressText: row['addressText'] as String?,
      ),
      arguments: [address],
    );
  }

  @override
  Future<int> insertStreet(NearestStreetEntity address) {
    return _nearestStreetEntityInsertionAdapter.insertAndReturnId(
      address,
      OnConflictStrategy.abort,
    );
  }
}
