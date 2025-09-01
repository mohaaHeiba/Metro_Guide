import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/pages/focus/foucs_page.dart';

Widget focsModeButtonWidget(final Map<String, dynamic> data) {
  final controller = Get.find<HomeController>();
  return ElevatedButton(
    onPressed: () async {
      controller.startLocationAddress();
      Get.to(
        FoucsPage(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 1000),
        arguments: data,
      );
    },
    child: Text("Lets Start"),
  );
}
