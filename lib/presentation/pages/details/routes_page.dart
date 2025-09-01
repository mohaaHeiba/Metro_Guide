import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/pages/details/details_page.dart';
import 'package:metro_guide/presentation/pages/details/seconde_details_page.dart';

class RoutesPage extends StatelessWidget {
  RoutesPage({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).route_details),
          bottom: TabBar(
            tabs: [
              Tab(text: S.of(context).Shortest_route_details),
              Tab(text: S.of(context).comfortable_route_details),
            ],
          ),
        ),
        body: TabBarView(children: [DetailsPage(), SecondeDetailsPage()]),
      ),
    );
  }
}
