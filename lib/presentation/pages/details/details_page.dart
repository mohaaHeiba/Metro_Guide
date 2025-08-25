import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:metro_guide/presentation/widgets/details_widgets/summarycard_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final routeData = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          summaryCardWidget(routeData, context),
          Center(child: Text("Hellow")),
        ],
      ),
    );
  }
}
