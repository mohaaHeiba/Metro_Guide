import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
