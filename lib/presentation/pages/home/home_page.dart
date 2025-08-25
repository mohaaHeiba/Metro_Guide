import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/card_widget.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/dropdown_widget.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/header_widget.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/textfield_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controll = Get.find<HomeController>();
    // final shortestRoute =await ;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // spacing: 10,
            children: [
              const SizedBox(),
              headerWidget(context),
              const SizedBox(height: 10),
              dropDown(
                "From",
                Icon(Icons.location_on),
                context,
                true,
                controll.stations,
                controll.cont1,
                RxBool(true),
              ),
              const SizedBox(height: 20),

              dropDown(
                "to",
                Icon(Icons.location_on_outlined),
                context,
                false,
                controll.stations,
                controll.cont2,
                controll.isAppearDropdownMenu2,
              ),
              const SizedBox(height: 10),

              Obx(
                () => controll.isSearch.value
                    ? textFieldWidget(context)
                    : const SizedBox(),
              ),

              ElevatedButton(
                onPressed: () {
                  controll.toggelSearch();
                },
                child: Obx(
                  () => Icon(
                    controll.isSearch.value
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Obx(
                () => ElevatedButton(
                  onPressed: controll.isAppearButton.value
                      ? () {
                          controll.showCards();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Show Ticket",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  child: controll.isCardsAppear.value
                      ? Obx(() {
                          if (controll.routes.isEmpty) {
                            return Center(child: Text("No routes found"));
                          } else {
                            return cardWidget(
                              context,
                              controll.pickUp,
                              controll.pickDown,
                              controll.routes.first,
                              controll.getColors(
                                controll.routes.first['totalStations'],
                              ),
                            );
                          }
                        })
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
