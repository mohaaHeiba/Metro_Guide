import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/widgets/details_widgets/summarycard_widget.dart';

class FoucsPage extends StatefulWidget {
  const FoucsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FoucsPageState createState() => _FoucsPageState();
}

class _FoucsPageState extends State<FoucsPage> {
  final controller = Get.find<HomeController>();
  late final Map<String, dynamic> routeData;

  @override
  void initState() {
    super.initState();
    routeData = Get.arguments as Map<String, dynamic>;
    controller.isFocusActive.value = true;
    controller.startLocationAddress();
  }

  @override
  void dispose() {
    controller.stopLocationLoop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            summaryCardWidget(routeData, context),
            const SizedBox(height: 20),
            Text(
              S.of(context).Shortest_route_details,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRouteCard(routeData, context),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _buildStationList(route, context),
    );
  }

  Widget _buildStationList(Map<String, dynamic> route, BuildContext context) {
    List<Widget> stationWidgets = [];

    // Get stations list
    if (route['type'] == 'DIRECT') {
      List<String> stations = List<String>.from(route['stations']);

      stationWidgets.addAll([
        _buildStationItem(controller.pickUp.value, true, false, context),
        ...stations.map(
          (station) => _buildStationItem(station, false, false, context),
        ),
        _buildStationItem(controller.pickDown.value, false, true, context),
      ]);
    } else if (route['type'] == 'TRANSFER') {
      // Get part2 list
      List<String> part2 = List<String>.from(route['part2']);

      stationWidgets.addAll([
        _buildStationItem(controller.pickUp.value, true, false, context),
        ...route['part1'].map(
          (station) => _buildStationItem(station, false, false, context),
        ),
        _buildTransferItem(
          route['transferAt'],
          route['line1'],
          route['line2'],
          context,
        ),
        ...part2.map(
          (station) => _buildStationItem(station, false, false, context),
        ),
        _buildStationItem(controller.pickDown.value, false, true, context),
      ]);
    } else if (route['type'] == '2 TRANSFER') {
      // Get part3 list
      List<String> part3 = List<String>.from(route['part3']);

      stationWidgets.addAll([
        _buildStationItem(controller.pickUp.value, true, false, context),
        ...route['part1'].map(
          (station) => _buildStationItem(station, false, false, context),
        ),
        _buildTransferItem(
          route['transfer1At'],
          route['line1'],
          route['line2'],
          context,
        ),
        ...route['part2'].map(
          (station) => _buildStationItem(station, false, false, context),
        ),
        _buildTransferItem(
          route['transfer2At'],
          route['line2'],
          route['line3'],
          context,
        ),
        ...part3.map(
          (station) => _buildStationItem(station, false, false, context),
        ),
        _buildStationItem(controller.pickDown.value, false, true, context),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).route_path,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...stationWidgets,
      ],
    );
  }

  Widget _buildStationItem(
    String stationName,
    bool isStart,
    bool isEnd,
    // bool isCurrent,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isStart
                  ? Colors.green[400]
                  : isEnd
                  ? Colors.red[400]
                  // : isCurrent?
                  // Colors.yellow[400]
                  : Colors.blue[400],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              stationName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isStart || isEnd
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          if (isStart)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green[400]!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                S.of(context).start,
                style: TextStyle(
                  color: Colors.green[400],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isEnd)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red[400]!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                S.of(context).end,
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransferItem(
    String transferStation,
    String fromLine,
    String toLine,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.scrim.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.scrim.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.swap_horiz,
              color: Theme.of(context).colorScheme.scrim.withOpacity(0.6),
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).transfer_at} $transferStation',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,

                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$fromLine → $toLine',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.scrim.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
