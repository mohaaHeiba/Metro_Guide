import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/pages/history/history_page.dart';
import 'package:metro_guide/presentation/pages/home/home_page.dart';
import 'package:metro_guide/presentation/pages/instructions/map_page.dart';
import 'package:metro_guide/presentation/pages/settings/settings_page.dart';

class NavigationbarPage extends StatelessWidget {
  NavigationbarPage({super.key});
  final currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomePage(),
      const MapPage(),
      const HistoryPage(),
      const SettingsPage(),
    ];

    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 33),
          child: IndexedStack(index: currentIndex.value, children: screens),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (index) => currentIndex.value = index,
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
