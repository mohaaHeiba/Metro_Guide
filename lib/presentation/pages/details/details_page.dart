import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/widgets/details_widgets/summarycard_widget.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});
  final routeData = Get.arguments as Map<String, dynamic>;
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          S.of(context).route_details,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: routeData.isEmpty
          ? Center(
              child: Text(
                S.of(context).no_routes_found,
                style: TextStyle(fontSize: 18, color: Colors.grey[400]),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                // spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  summaryCardWidget(routeData, context),
                  const SizedBox(height: 20),

                  // Shortest Route Details
                  Text(
                    S.of(context).route_details,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Single Route Card
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Route Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  route['type'] == 'DIRECT'
                      ? S.of(context).direct_route
                      : route['type'] == 'TRANSFER'
                      ? S.of(context).tranfers
                      : S.of(context).tranfers_2,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${route['price']} ${S.of(context).egp}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Direction Information
          _buildDirectionCard(route, context),
          const SizedBox(height: 16),

          // Route Details
          _buildRouteDetails(route, context),
          const SizedBox(height: 16),

          // Station List
          _buildStationList(route, context),
        ],
      ),
    );
  }

  Widget _buildDirectionCard(Map<String, dynamic> route, BuildContext context) {
    Color directionColor = Theme.of(context).colorScheme.primary;
    IconData? directionIcon;
    String directionText;

    if (route['type'] == 'DIRECT') {
      directionIcon = Icons.directions_subway;
      directionText = '${S.of(context).towards}: ${route['direction']}';
    } else if (route['type'] == 'TRANSFER') {
      directionText =
          '${S.of(context).towards}: ${route['direction1']} ${S.of(context).symbol} ${route['direction2']}';
    } else if (route['type'] == '2 TRANSFER') {
      directionText =
          '${S.of(context).towards}: ${route['direction1']} ${S.of(context).symbol} ${route['direction2']} ${S.of(context).symbol} ${route['direction3']}';
    } else {
      directionIcon = Icons.help;
      directionText = S.of(context).no_routes_found;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: directionColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: directionColor.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(directionIcon, color: directionColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              directionText,
              style: TextStyle(
                color: directionColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteDetails(Map<String, dynamic> route, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildInfoItem(
            Icons.access_time,
            S.of(context).duration,
            route['time'],
            Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: buildInfoItem(
            Icons.straighten,
            S.of(context).stations,
            '${route['totalStations']}',
            Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: buildInfoItem(
            Icons.route,
            S.of(context).type,
            route['type'] == 'DIRECT'
                ? S.of(context).direct_route
                : route['type'] == 'TRANSFER'
                ? S.of(context).tranfers
                : S.of(context).tranfers,
            Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
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
