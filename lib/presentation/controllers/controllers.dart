import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/presentation/pages/history/history_page.dart';
import 'package:metro_guide/presentation/pages/home/home_page.dart';
import 'package:metro_guide/presentation/pages/map/map_page.dart';
import 'package:metro_guide/presentation/pages/settings/settings_page.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  final List<Widget> screens = [
    HomePage(),
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

  final pickUp = ''.obs;
  final pickDown = ''.obs;

  void toggelSearch() {
    isSearch.value = !isSearch.value;
  }

  void showCards() {
    isCardsAppear.value = true;
  }
}
