import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:metro_guide/core/services/location_service.dart';
import 'package:metro_guide/data/datasources/station_database.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';
import 'package:metro_guide/domain/use_cases/find_routes.dart';
import 'package:metro_guide/presentation/pages/history/history_page.dart';
import 'package:metro_guide/presentation/pages/home/home_page.dart';
import 'package:metro_guide/presentation/pages/map/map_page.dart';
import 'package:metro_guide/presentation/pages/settings/settings_page.dart';
import 'package:metro_guide/presentation/widgets/custom_widgets/snackbar_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleLanguage() {
    isArabic.value = !isArabic.value;
    var locale = isArabic.value
        ? const Locale('ar', 'EG')
        : const Locale('en', 'US');
    Get.updateLocale(locale);
  }
}

class HomeController extends GetxController {
  final cont1 = TextEditingController();
  final cont2 = TextEditingController();

  final isCardsAppear = false.obs;
  final isSearch = false.obs;
  final isAppearDropdownMenu2 = false.obs;
  final isAppearButton = false.obs;

  final pickUp = ''.obs;
  final pickDown = ''.obs;
  final routes = <Map<String, dynamic>>[].obs;

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
    final data = await dbController.database.metrostationdao.getallStation();
    return data;
  }

  final stations = [].obs;

  @override
  void onInit() {
    // TODO: implement initState
    super.onInit();
    loadDataBase();
    getData();

    cont1.addListener(() {
      final text1 = cont1.text.toLowerCase();
      final text2 = cont2.text.toLowerCase();

      final match1 = stations.any((value) => value.contains(text1));
      final match2 = stations.any((value) => value.contains(text2));
      // print(match);

      if (match1) {
        isAppearDropdownMenu2.value = true;
      }
    });

    cont2.addListener(() {
      final text1 = cont1.text.toLowerCase();
      final text2 = cont2.text.toLowerCase();

      final match1 = stations.any((value) => value.contains(text1));
      final match2 = stations.any((value) => value.contains(text2));
      // print(match);

      if (text1 == text2) {
        isAppearButton.value = false;
      } else if (match2) {
        isAppearButton.value = true;
      }
    });
  }

  Future<void> loadDataBase() async {
    final dbController = Get.find<DatabaseController>();
    final data = await dbController.database.metrostationdao
        .getallStationArabic();
    stations.addAll(data);
    print(stations);
  }

  Color getColors(int totalStations) {
    if (totalStations <= 9) return Colors.amber;
    if (totalStations <= 16) return Colors.green;
    if (totalStations <= 23) return Colors.pink;
    return Colors.brown;
  }

  final locationService = LocationService();

  Future<void> getCurrentLocation() async {
    try {
      final position = await locationService.determinePosition();
      showSnackBar(
        "Your Location",
        "Current location: ${position.latitude}, ${position.longitude}",
        Colors.green,
      );
    } catch (e) {
      showSnackBar("Error s", "$e", Colors.red);
    }
  }
}

class DatabaseController extends GetxController {
  late final StationDatabase database;

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

    // test: load stations English
    final data = await database.metrostationdao.getallStationEnglish();
    print("Stations: $data");
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
