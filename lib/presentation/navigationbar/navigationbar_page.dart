import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';

class NavigationbarPage extends StatelessWidget {
  const NavigationbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationController>();

    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 33),
          child: IndexedStack(
            index: controller.currentIndex.value,
            children: controller.screens,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.currentIndex.value = index,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: S.of(context).nav_home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: S.of(context).nav_instructions,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: S.of(context).nav_history,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: S.of(context).nav_history,
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
