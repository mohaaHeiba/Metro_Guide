import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/card_widget.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/dropdown_widget.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/header_widget.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/textfield_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final cont1 = TextEditingController();
  final cont2 = TextEditingController();

  final isCardsAppear = false.obs;
  final isSearch = false.obs;

  final pickUp = ''.obs;
  final pickDown = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 10,
            children: [
              const SizedBox(),
              headerWidget(context),
              const SizedBox(),
              dropDown("From", Icon(Icons.location_on), context, true),
              const SizedBox(),

              dropDown("to", Icon(Icons.location_on_outlined), context, false),
              const SizedBox(),

              Obx(
                () => isSearch.value
                    ? textFieldWidget(context)
                    : const SizedBox(),
              ),
              ElevatedButton(
                onPressed: () {
                  isSearch.value = !isSearch.value;
                },
                child: Obx(
                  () => Icon(
                    isSearch.value ? Icons.arrow_upward : Icons.arrow_downward,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  isCardsAppear.value = true;
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Show Ticket",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  child: isCardsAppear.value
                      ? Container(child: cardWidget(context))
                      : const SizedBox(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
