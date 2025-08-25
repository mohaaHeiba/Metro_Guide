import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:metro_guide/data/datasources/station_database.dart';
import 'package:metro_guide/presentation/pages/history/history_page.dart';
import 'package:metro_guide/presentation/pages/home/home_page.dart';
import 'package:metro_guide/presentation/pages/map/map_page.dart';
import 'package:metro_guide/presentation/pages/settings/settings_page.dart';
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

  void toggelSearch() {
    isSearch.value = !isSearch.value;
  }

  void showCards() {
    isCardsAppear.value = true;
    pickUp.value = cont1.text;
    pickDown.value = cont2.text;
  }

  final stations = [].obs;

  @override
  void onInit() {
    // TODO: implement initState
    super.onInit();
    loadDataBase();

    cont1.addListener(() {
      final text1 = cont1.text.toLowerCase();
      final text2 = cont2.text.toLowerCase();

      final match1 = stations.any((value) => value.contains(text2));
      final match2 = stations.any((value) => value.contains(text1));
      // print(match);

      if (match1) {
        isAppearDropdownMenu2.value = true;
      }
      if (match2) {
        isAppearButton.value = true;
      }
    });

    cont2.addListener(() {});
  }

  Future<void> loadDataBase() async {
    final dbController = Get.find<DatabaseController>();
    final data = await dbController.database.metrostationdao
        .getallStationArabic();
    stations.addAll(data);
    print(stations);
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
