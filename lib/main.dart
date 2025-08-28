import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:metro_guide/app.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  final initi = Get.put(DatabaseController(), permanent: true);
  await initi.initDatabase();

  Get.put(HomeController(), permanent: true);

  Get.put(NavigationController(), permanent: true);
  Get.put(SettingsController(), permanent: true);

  runApp(const MyApp());
}
