import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/pages/settings/contactUs_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 220, height: 220),
            const SizedBox(height: 30),

            Obx(
              () => SwitchListTile(
                title: const Text("Dark Mode"),
                value: controller.isDarkMode.value,
                onChanged: (value) => controller.toggleTheme(),
                secondary: const Icon(Icons.brightness_6),
              ),
            ),

            const Divider(height: 30),

            // 🌍 Language Button
            Obx(
              () => ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                  "Language: ${controller.isArabic.value ? "العربية" : "English"}",
                ),
                trailing: ElevatedButton(
                  onPressed: () => controller.toggleLanguage(),
                  child: const Text("Change"),
                ),
              ),
            ),

            const Divider(height: 30),

            // ℹ️ About App
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              subtitle: const Text("Metro Guide v1.0.0"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Metro Guide",
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.train, size: 40),
                  applicationLegalese: "Developed by Mohamed Heiba © 2025",
                );
              },
            ),
            const Divider(height: 30),

            ListTile(
              leading: const Icon(Icons.contact_support_sharp),
              title: const Text("Coutact Us"),
              onTap: () {
                Get.to(ContactUsPage(), transition: Transition.rightToLeft);
              },
            ),
          ],
        ),
      ),
    );
  }
}
