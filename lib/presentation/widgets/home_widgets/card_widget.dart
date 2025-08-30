import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/pages/details/details_page.dart';

Widget cardWidget(
  BuildContext context,
  final pickUp,
  final pickDown,
  final shortsetRoute,
  final color,
) {
  // final route = shortsetRoute.first;
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                // offset: Offset(0, 5),
                blurRadius: 5,
              ),
            ],
          ),
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      S.of(context).journey_details,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        // SizedBox(width: 8),
                        Text(
                          "${S.of(context).duration} ${shortsetRoute['time']}" ??
                              S.of(context).unknown,
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        // SizedBox(width: 8),
                        Text(
                          "${S.of(context).price}       ${shortsetRoute['price']}" ??
                              S.of(context).unknown,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        // SizedBox(width: 8),
                        Text(
                          "${S.of(context).stations}:  ${shortsetRoute['totalStations']}" ??
                              S.of(context).unknown,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        // SizedBox(width: 8),
                        Text(
                          "${S.of(context).transfers}:${shortsetRoute['type'] == 'direct' ? 1 : 2}" ??
                              S.of(context).unknown,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// Button
              ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => DetailsPage(),
                    transition: Transition.rightToLeft,
                    arguments: shortsetRoute,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).show_more,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          height: 280,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color[800]],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                // offset: Offset(0, 5),
                blurRadius: 5,
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.confirmation_number,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        S.of(context).valid,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        9,
                        (index) => Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            S.of(context).show_ticket_card,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    "${S.of(context).from_card}: $pickUp" ??
                                        S.of(context).unknown,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    "${S.of(context).to_card}: $pickDown" ??
                                        S.of(context).unknown,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Text(
                                " ${S.of(context).egp}  ${shortsetRoute['price']}" ??
                                    S.of(context).unknown,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
