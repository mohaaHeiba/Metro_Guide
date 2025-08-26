import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';

Widget textFieldWidget(BuildContext context, controllText) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controllText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          hintText: "Where do you wanna to go",
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 15,
          ),
          suffixIcon: IconButton(
            onPressed: () async {
              final homeController = Get.find<HomeController>();
              await homeController.getNearestStationForPickDown(
                controllText.text,
              );
            },
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          ),
        ),
      ),
    ),
  );
}
