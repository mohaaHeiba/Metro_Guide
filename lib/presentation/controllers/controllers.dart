import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:metro_guide/core/services/location_service.dart';
import 'package:metro_guide/data/datasources/station_database.dart';
import 'package:metro_guide/domain/entities/nearest_street_entity.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';
import 'package:metro_guide/domain/use_cases/find_nearest_station.dart';
import 'package:metro_guide/domain/use_cases/find_routes.dart';
import 'package:metro_guide/presentation/pages/history/history_page.dart';
import 'package:metro_guide/presentation/pages/home/home_page.dart';
import 'package:metro_guide/presentation/pages/instructions/map_page.dart';
import 'package:metro_guide/presentation/pages/settings/settings_page.dart';
import 'package:metro_guide/presentation/widgets/custom_widgets/snackbar_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  final List<Widget> screens = [
    const HomePage(),
    const MapPage(),
    const HistoryPage(),
    const SettingsPage(),
  ];
}

class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var isArabic = false.obs;
  final box = GetStorage();
  final theme = GetStorage();

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    final dark = isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

    theme.write('theme', isDarkMode.value ? 'dark' : 'light');
    Get.changeThemeMode(dark);
  }

  void toggleLanguage() {
    isArabic.value = !isArabic.value;
    var locale = isArabic.value
        ? const Locale('ar', 'EG')
        : const Locale('en', 'US');

    box.write('lang', isArabic.value ? 'ar' : 'en');

    Get.updateLocale(locale);

    final homeController = Get.find<HomeController>();
    homeController.cont1.clear();
    homeController.cont2.clear();
    homeController.isCardsAppear.value = false;
    homeController.isAppearDropdownMenu2.value = false;

    homeController.loadDataBase();
  }

  @override
  void onInit() {
    super.onInit();

    final storedTheme = theme.read('theme') ?? 'dark';
    isDarkMode.value = storedTheme == 'dark';

    final storedLang = box.read('lang') ?? 'en';
    isArabic.value = storedLang == 'ar';

    Get.updateLocale(
      isArabic.value ? const Locale('ar', 'EG') : const Locale('en', 'US'),
    );

    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

class HomeController extends GetxController {
  final settings = Get.find<SettingsController>();

  bool get isArabic => settings.isArabic.value;
  // =================== Controllers ===================
  final cont1 = TextEditingController();
  final cont2 = TextEditingController();
  final textfield = TextEditingController();

  // =================== UI states ===================
  final isCardsAppear = false.obs;
  final isSearch = false.obs;
  final isAppearDropdownMenu2 = false.obs;
  final isAppearButton = false.obs;

  // =================== Pick up & down ===================
  final pickUp = ''.obs;
  final pickDown = ''.obs;

  final routes = <Map<String, dynamic>>[].obs;
  final stations = [].obs;

  // =================== Services ===================
  final locationService = LocationService();
  final flutter_map.MapController mapController = flutter_map.MapController();
  final TextEditingController searchController = TextEditingController();

  // =================== Methods ===================
  void toggelSearch() {
    isSearch.value = !isSearch.value;
  }

  Future<void> showCards() async {
    isCardsAppear.value = true;
    pickUp.value = cont1.text;
    pickDown.value = cont2.text;

    final FindRoutes findRoute = FindRoutes();
    final result = await findRoute.findRoutes(pickUp.value, pickDown.value);
    routes.assignAll(result);

    print("Found routes: $routes");
  }

  Future<List<StationEntity>> getData() async {
    final dbController = Get.find<DatabaseController>();
    return await dbController.database.metrostationdao.getallStation();
  }

  Future<void> loadDataBase() async {
    final dbController = Get.find<DatabaseController>();
    final isArabic = Get.find<SettingsController>().isArabic.value;

    final data = isArabic ? dbController.stationAr : dbController.stationEn;

    stations.clear();
    stations.addAll(data.map((s) => s.toString().toLowerCase()).toList());
    print("$stations");
  }

  Future<Position> getlocation() async {
    return await locationService.determinePosition();
  }

  // =================== Map + Nearest Station ===================
  Future<LatLng> getUserLocation(bool nuh) async {
    final pos = await getlocation();

    return LatLng(pos.latitude, pos.longitude);
  }

  Future<void> searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        mapController.move(LatLng(loc.latitude, loc.longitude), 14);
      }
    } catch (e) {
      print("مش موجود: $query");
    }
  }

  // =================== Extra helpers ===================
  Future<void> getCurrentLocation() async {
    try {
      final position = await locationService.determinePosition();

      final stationEntities = await getData();
      final findNearestStation = FindNearestStation(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      final nearest = findNearestStation.findNearestStation(stationEntities);

      cont1.text = isArabic ? nearest.name_ar ?? "" : nearest.name_en ?? "";

      print("Nearest Station: ${cont1.text}");

      showSnackBar(
        "Nearest Station",
        "You are near: ${cont1.text}",
        Colors.blue,
      );
    } catch (e) {
      showSnackBar("Error", "$e", Colors.red);
    }
  }

  Future<Position?> getCoordinatesFromAddress(String street) async {
    try {
      List<Location> locations = await locationFromAddress(street);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        return Position(
          latitude: location.latitude,
          longitude: location.longitude,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        );
      }
      return null;
    } catch (e) {
      showSnackBar(
        'Error',
        "Error getting coordinates from address: $e",
        Colors.red[600]!,
      );
      return null;
    }
  }

  Future<void> getNearestStationForPickDown(
    String street,
    TextEditingController? controlltext,
  ) async {
    try {
      final dbController = Get.find<DatabaseController>();

      // cheack in cash first
      final cached = await dbController.database.neareststreetdao.findByAddress(
        street,
      );

      if (cached != null) {
        controlltext?.text = isArabic
            ? cached.name_ar ?? ""
            : cached.name_en ?? "";

        showSnackBar(
          "Nearest Station (Cached)",
          "You are near: ${controlltext?.text}",
          Colors.green,
        );
        return;
      }

      // geocding
      final position = await getCoordinatesFromAddress(street);
      if (position == null) return;

      final stationEntities = await getData();
      final findNearestStation = FindNearestStation(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      final nearest = findNearestStation.findNearestStation(stationEntities);

      controlltext?.text = isArabic
          ? nearest.name_ar ?? ""
          : nearest.name_en ?? "";

      // save data
      final newStreet = NearestStreetEntity(addressText: street);
      final nearestStreetId = await dbController.database.neareststreetdao
          .insertStreet(newStreet);

      // update metro_staions
      final updatedStation = StationEntity(
        station_id: nearest.station_id,
        name_ar: nearest.name_ar,
        name_en: nearest.name_en,
        latitude: nearest.latitude,
        longitude: nearest.longitude,
        line: nearest.line,
        nearestId: nearestStreetId,
      );

      final rowsAffected = await dbController.database.metrostationdao
          .updateStreet(updatedStation);

      showSnackBar(
        "Nearest Station (Online)",
        "You are near: ${controlltext?.text}",
        Colors.blue,
      );
    } catch (e) {
      print("❌ Error in getNearestStationForPickDown: $e");
      showSnackBar("Error", "$e", Colors.red);
    }
  }

  Color getColors(int totalStations) {
    if (totalStations <= 9) return Colors.amber;
    if (totalStations <= 16) return Colors.green;
    if (totalStations <= 23) return Colors.pink;
    return Colors.brown;
  }

  // =================== Lifecycle ===================
  @override
  void onInit() {
    super.onInit();
    loadDataBase();
    getData();

    cont1.addListener(() {
      final text1 = cont1.text.toLowerCase();
      final match1 = stations.any((station) => station.contains(text1));
      isAppearDropdownMenu2.value = match1;
    });

    cont2.addListener(() {
      final text1 = cont1.text.toLowerCase();
      final text2 = cont2.text.toLowerCase();

      final match2 = stations.any((station) => station.contains(text2));

      if (text1 == text2) {
        isAppearButton.value = false;
      } else {
        isAppearButton.value = match2;
      }
    });
  }
}

class DatabaseController extends GetxController {
  late final StationDatabase database;
  late final stationAr = [].obs;
  late final stationEn = [].obs;
  @override
  void onInit() {
    super.onInit();
    // initDatabase();
  }

  Future<void> initDatabase() async {
    await _copyDatabase();
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'stations.DB');

    database = await $FloorStationDatabase.databaseBuilder(dbPath).build();

    // // test: load stations English
    final data = await database.metrostationdao.getallStation();
    stationAr.assignAll(data.map((station) => station?.name_ar).toList());
    stationEn.assignAll(data.map((station) => station?.name_en).toList());

    // print("Stations: $stationAr");
    // print("Stations: $stationEn");
  }

  Future<void> _copyDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'stations.DB');

    if (File(path).existsSync()) return;

    ByteData data = await rootBundle.load('assets/data/stations.DB');
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(path).writeAsBytes(bytes);
  }
}
