import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/domain/entities/station_entity.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';

class FindRoutes {
  final controll = Get.find<HomeController>();

  List<StationEntity>? cachedStations;

  Future<List<StationEntity>> _getData() async {
    if (cachedStations != null) return cachedStations!;
    cachedStations = await controll.getData();
    return cachedStations!;
  }

  int _getPrice(int totalStation) {
    if (totalStation <= 9) return 8;
    if (totalStation <= 16) return 10;
    if (totalStation <= 23) return 15;
    return 20;
  }

  String _getTime(int totalStation) {
    final totalMinutes = totalStation * 2;
    if (totalMinutes >= 60) {
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      return "$hours h $minutes min";
    }
    return "$totalMinutes min";
  }

  String _getDirection(List<String> line, String from, String to) {
    final start = line.indexOf(from);
    final end = line.indexOf(to);

    if (start < end) {
      return line.last;
    } else {
      return line.first;
    }
  }

  List<String> _getSubPath(List<String> line, String from, String to) {
    final start = line.indexOf(from);
    final end = line.indexOf(to);

    if (start < end) {
      return line.sublist(start + 1, end);
    } else {
      return line.sublist(end + 1, start).reversed.toList();
    }
  }

  Future<Map<String, List<String>>> _getStationsByLine() async {
    final stations = await _getData();
    Map<String, List<String>> linesMap = {};

    for (var station in stations) {
      final line = station.line ?? 'unknown';
      final name = station.name_ar ?? 'unnamed';

      linesMap.putIfAbsent(line, () => []);
      linesMap[line]!.add(name.toLowerCase());
    }

    return linesMap;
  }

  Future<List<Map<String, dynamic>>> findRoutes(
    String fromStation,
    String toStation,
  ) async {
    final linesMap = await _getStationsByLine();
    final from = fromStation.toLowerCase();
    final to = toStation.toLowerCase();

    List<Map<String, dynamic>> routes = [];

    // Find direct routes (same line)
    for (var entry in linesMap.entries) {
      final line = entry.value;
      final lineName = entry.key;

      if (line.contains(from) && line.contains(to)) {
        final startIndex = line.indexOf(from);
        final endIndex = line.indexOf(to);

        List<String> stations = [];
        String direction;
        if (startIndex < endIndex) {
          stations = line.sublist(startIndex + 1, endIndex);
          direction = line.last;
        } else {
          stations = line.sublist(endIndex + 1, startIndex).reversed.toList();
          direction = line.first;
        }

        routes.add({
          'type': 'DIRECT',
          'line': lineName,
          'direction': direction,
          'stations': stations,
          'totalStations': stations.length + 1,
          'price': _getPrice(stations.length + 1),
          'time': _getTime(stations.length + 1),
        });
      }
    }

    // Find transfer routes (different lines)
    for (var line1 in linesMap.entries) {
      if (!line1.value.contains(from)) continue;

      for (var line2 in linesMap.entries) {
        if (line1.key == line2.key) continue;
        if (!line2.value.contains(to)) continue;

        // Find transfer stations
        List<String> transferStations = [];
        for (var station in line1.value) {
          if (line2.value.contains(station) &&
              station != from &&
              station != to) {
            transferStations.add(station);
          }
        }

        for (var transfer in transferStations) {
          final part1 = _getSubPath(line1.value, from, transfer);
          final part2 = _getSubPath(line2.value, transfer, to);

          final totalStations = part1.length + part2.length + 2;

          routes.add({
            'type': 'TRANSFER',
            'line1': line1.key,
            'line2': line2.key,
            'direction1': _getDirection(line1.value, from, transfer),
            'direction2': _getDirection(line2.value, transfer, to),
            'transferAt': transfer,
            'part1': part1,
            'part2': part2,
            'totalStations': totalStations,
            'price': _getPrice(totalStations),
            'time': _getTime(totalStations),
          });
        }
      }
    }

    // Find 2-transfer routes
    for (var line1 in linesMap.entries) {
      if (!line1.value.contains(from)) continue;

      for (var line2 in linesMap.entries) {
        if (line1.key == line2.key) continue;

        // Find transfer stations between line1 and line2
        List<String> transferStations1to2 = [];
        for (var station in line1.value) {
          if (line2.value.contains(station) && station != from) {
            transferStations1to2.add(station);
          }
        }

        for (var line3 in linesMap.entries) {
          if (line1.key == line3.key || line2.key == line3.key) continue;
          if (!line3.value.contains(to)) continue;

          // Find transfer stations between line2 and line3
          List<String> transferStations2to3 = [];
          for (var station in line2.value) {
            if (line3.value.contains(station) &&
                station != to &&
                !transferStations1to2.contains(station)) {
              transferStations2to3.add(station);
            }
          }

          for (var transfer1 in transferStations1to2) {
            for (var transfer2 in transferStations2to3) {
              if (transfer1 != transfer2) {
                final part1 = _getSubPath(line1.value, from, transfer1);
                final part2 = _getSubPath(line2.value, transfer1, transfer2);
                final part3 = _getSubPath(line3.value, transfer2, to);

                final totalStations =
                    part1.length + part2.length + part3.length + 3;

                routes.add({
                  'type': '2 TRANSFER',
                  'line1': line1.key,
                  'line2': line2.key,
                  'line3': line3.key,
                  'direction1': _getDirection(line1.value, from, transfer1),
                  'direction2': _getDirection(
                    line2.value,
                    transfer1,
                    transfer2,
                  ),
                  'direction3': _getDirection(line3.value, transfer2, to),
                  'transfer1At': transfer1,
                  'transfer2At': transfer2,
                  'part1': part1,
                  'part2': part2,
                  'part3': part3,
                  'totalStations': totalStations,
                  'price': _getPrice(totalStations),
                  'time': _getTime(totalStations),
                });
              }
            }
          }
        }
      }
    }

    // Sort
    routes.sort((a, b) => (a['totalStations']).compareTo(b['totalStations']));

    return routes;
  }
}
