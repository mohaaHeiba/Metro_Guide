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
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$StationDatabase extends StationDatabase {
  _$StationDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MetroStationDao? _metrostationdaoInstance;

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
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `metro_stations` (`station_id` INTEGER PRIMARY KEY AUTOINCREMENT, `name_ar` TEXT, `name_en` TEXT, `latitude` REAL, `longitude` REAL, `line` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MetroStationDao get metrostationdao {
    return _metrostationdaoInstance ??=
        _$MetroStationDao(database, changeListener);
  }
}

class _$MetroStationDao extends MetroStationDao {
  _$MetroStationDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<String>> getallStationArabic() async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT name_ar from metro_stations',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<List<String>> getallStationEnglish() async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT name_en from metro_stations',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<List<StationEntity>> getallStation() async {
    return _queryAdapter.queryList(
        'SELECT name_ar, name_en, latitude,longitude, line from metro_stations',
        mapper: (Map<String, Object?> row) => StationEntity(
            station_id: row['station_id'] as int?,
            name_ar: row['name_ar'] as String?,
            name_en: row['name_en'] as String?,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?,
            line: row['line'] as String?));
  }

  @override
  Future<List<StationEntity>> getStationPickUP(String pickUp) async {
    return _queryAdapter.queryList(
        'SELECT name_ar, latitude, longitude, line FROM metro_stations WHERE name_en = ?1',
        mapper: (Map<String, Object?> row) => StationEntity(station_id: row['station_id'] as int?, name_ar: row['name_ar'] as String?, name_en: row['name_en'] as String?, latitude: row['latitude'] as double?, longitude: row['longitude'] as double?, line: row['line'] as String?),
        arguments: [pickUp]);
  }

  @override
  Future<List<StationEntity>> getStationPickDown(String pickDown) async {
    return _queryAdapter.queryList(
        'SELECT name_ar, latitude, longitude, line FROM metro_stations WHERE name_en = ?1',
        mapper: (Map<String, Object?> row) => StationEntity(station_id: row['station_id'] as int?, name_ar: row['name_ar'] as String?, name_en: row['name_en'] as String?, latitude: row['latitude'] as double?, longitude: row['longitude'] as double?, line: row['line'] as String?),
        arguments: [pickDown]);
  }
}
