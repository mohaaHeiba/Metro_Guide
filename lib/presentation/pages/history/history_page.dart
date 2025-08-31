import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/widgets/custom_widgets/snackbar_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                S.of(context).nav_history,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          // Clear History Button
          Obx(() {
            if (controller.historyItems.isEmpty) {
              return const SizedBox();
            }
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () => controller.clearHistory(context),
                icon: const Icon(Icons.clear_all, size: 16),
                label: Text('Clear All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            );
          }),

          // History List
          Expanded(
            child: Obx(() {
              if (controller.historyItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No history yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.historyItems.length,
                itemBuilder: (context, index) {
                  final item = controller.historyItems[index];
                  return HistoryCard(
                    historyItem: item,
                    onTap: () => controller.reuseRoute(context, item),
                    onDelete: () =>
                        controller.deleteHistoryItem(context, index),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> historyItem;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const HistoryCard({
    super.key,
    required this.historyItem,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryController>();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Icon(
          Icons.route,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Row(
          children: [
            Expanded(
              child: FutureBuilder<String>(
                future: historyItem['fromStationId'] != null
                    ? controller.getStationNameInCurrentLanguage(
                        historyItem['fromStationId'],
                      )
                    : controller.getStationNameByName(
                        historyItem['from'] ?? '',
                      ),
                builder: (context, snapshot) {
                  final fromName = snapshot.data ?? historyItem['from'] ?? '';
                  return Text(
                    fromName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
            const Text(' → '),

            Expanded(
              child: FutureBuilder<String>(
                future: historyItem['toStationId'] != null
                    ? controller.getStationNameInCurrentLanguage(
                        historyItem['toStationId'],
                      )
                    : controller.getStationNameByName(historyItem['to'] ?? ''),
                builder: (context, snapshot) {
                  final toName = snapshot.data ?? historyItem['to'] ?? '';
                  return Text(
                    toName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
          ],
        ),
        subtitle: Text(
          '${historyItem['time'] ?? ''} • ${historyItem['totalStations'] ?? 0} ${S.of(context).stations}',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.close, size: 18),
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}

class HistoryController extends GetxController {
  final historyItems = <Map<String, dynamic>>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    final savedHistory = storage.read('route_history') ?? [];
    historyItems.assignAll(List<Map<String, dynamic>>.from(savedHistory));
  }

  void refreshHistoryDisplay() {
    final currentItems = List<Map<String, dynamic>>.from(historyItems);
    historyItems.clear();
    historyItems.addAll(currentItems);
  }

  // Get station name in current language
  Future<String> getStationNameInCurrentLanguage(int? stationId) async {
    if (stationId == null) return '';

    try {
      final dbController = Get.find<DatabaseController>();
      final allStations = await dbController.database.metrostationdao
          .getallStation();

      for (final station in allStations) {
        if (station?.station_id == stationId) {
          final settings = Get.find<SettingsController>();
          return settings.isArabic.value
              ? station.name_ar ?? ''
              : station.name_en ?? '';
        }
      }

      return '';
    } catch (e) {
      print("Error getting station name for ID $stationId: $e");
      return '';
    }
  }

  // Get station name by name
  Future<String> getStationNameByName(String stationName) async {
    if (stationName.isEmpty) return '';

    try {
      final dbController = Get.find<DatabaseController>();
      final allStations = await dbController.database.metrostationdao
          .getallStation();

      for (final station in allStations) {
        if (station?.name_ar?.toLowerCase() == stationName.toLowerCase() ||
            station?.name_en?.toLowerCase() == stationName.toLowerCase()) {
          final settings = Get.find<SettingsController>();
          return settings.isArabic.value
              ? station.name_ar ?? ''
              : station.name_en ?? '';
        }
      }

      return stationName; // Return original name if not found
    } catch (e) {
      print("Error getting station name for $stationName: $e");
      return stationName;
    }
  }

  void saveHistory() {
    storage.write('route_history', historyItems.toList());
  }

  void addToHistory(Map<String, dynamic> route) {
    // Add current timestamp
    final historyItem = {...route, 'date': DateTime.now().toString()};

    // Remove duplicate if exists (same from/to or same station IDs)
    historyItems.removeWhere(
      (item) =>
          (item['from'] == route['from'] && item['to'] == route['to']) ||
          (item['fromStationId'] == route['fromStationId'] &&
              item['toStationId'] == route['toStationId']),
    );

    // Add to beginning of list
    historyItems.insert(0, historyItem);

    // Keep only last 20 items
    if (historyItems.length > 20) {
      historyItems.removeRange(20, historyItems.length);
    }

    saveHistory();
  }

  void deleteHistoryItem(BuildContext context, int index) {
    historyItems.removeAt(index);
    saveHistory();

    showSnackBar(
      S.of(context).nav_history,
      S.of(context).route_removed,
      Colors.orange,
    );
  }

  void clearHistory(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(S.of(context).clear_history),
        content: Text(S.of(context).no_history_desc),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              historyItems.clear();
              saveHistory();
              Get.back();

              showSnackBar(
                S.of(context).nav_history,
                S.of(context).all_history_cleared,
                Colors.red,
              );
            },
            child: Text(
              S.of(context).clear,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void reuseRoute(
    BuildContext context,
    Map<String, dynamic> historyItem,
  ) async {
    final homeController = Get.find<HomeController>();

    // Get station names in current language (handle backward compatibility)
    String fromName, toName;

    if (historyItem['fromStationId'] != null) {
      fromName = await getStationNameInCurrentLanguage(
        historyItem['fromStationId'],
      );
    } else {
      fromName = await getStationNameByName(historyItem['from'] ?? '');
    }

    if (historyItem['toStationId'] != null) {
      toName = await getStationNameInCurrentLanguage(
        historyItem['toStationId'],
      );
    } else {
      toName = await getStationNameByName(historyItem['to'] ?? '');
    }

    // Set the route in home controller
    homeController.cont1.text = fromName;
    homeController.cont2.text = toName;

    // Navigate to home page
    final navigationController = Get.find<NavigationController>();
    navigationController.currentIndex.value = 0;

    showSnackBar(
      S.of(context).route_loaded,
      '${S.of(context).route_path} "$fromName" ${S.of(context).to} "$toName" ${S.of(context).route_loaded_desc}',
      Colors.green,
    );
  }
}
