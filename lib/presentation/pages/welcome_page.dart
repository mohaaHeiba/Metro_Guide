import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:metro_guide/core/services/location_service.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/navigationbar/navigationbar_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final login = GetStorage();
  final locationService = LocationService();
  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 220, height: 220),
            const SizedBox(height: 30),
            Text(
              S.of(context).app_name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              S.of(context).app_desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 50),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              onPressed: () async {
                login.write("loginBefore", true);
                Get.off(NavigationbarPage(), transition: Transition.fadeIn);
                await locationService.determinePosition();
              },
              child: Text(
                S.of(context).get_started,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                controller.toggleLanguage();
              },
              child: Obx(
                () => Text(controller.isArabic.value ? 'English' : "عربي"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
