import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/presentation/controllers/controllers.dart';
import 'package:metro_guide/presentation/pages/map_locations.dart';

Widget dropDown(
  String label,
  Icon icon,
  BuildContext context,
  bool appearIcon2,
  final stations,
  var cont,
  final isEnbeld,
) {
  final controll = Get.find<HomeController>();
  return SizedBox(
    child: Row(
      children: [
        Expanded(
          child: Obx(
            () => Container(
              decoration: BoxDecoration(
                color: isEnbeld.value
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  // : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  width: 1,
                ),
                boxShadow: [
                  isEnbeld.value
                      ? BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      : BoxShadow(),
                ],
              ),

              child: DropdownMenu<String>(
                dropdownMenuEntries: [
                  for (var station in stations)
                    DropdownMenuEntry(
                      value: station,
                      label: station ?? "unKnown",
                    ),
                ],
                controller: cont,
                requestFocusOnTap: true,

                enableSearch: true,
                enableFilter: true,
                enabled: isEnbeld.value,
                width: double.infinity,
                menuHeight: 300,
                inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 8,
                    vertical: 15,
                  ),
                  hintStyle: TextStyle(
                    color: isEnbeld.value
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.5),
                  ),
                ),

                hintText: label,
                onSelected: (a) {
                  cont.text = a?.toLowerCase() ?? "";
                  print(cont);
                },
              ),
            ),
          ),
        ),
        appearIcon2
            ? IconButton(
                onPressed: () async {
                  await controll.getCurrentLocation();
                },
                icon: Icon(Icons.my_location),
              )
            : SizedBox(),
        IconButton(
          onPressed: () {
            Get.to(
              MapLocations(cont: cont),
              transition: Transition.rightToLeft,
            );
          },
          icon: icon,
        ),
      ],
    ),
  );
}
