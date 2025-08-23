import 'package:flutter/material.dart';

Widget headerWidget(dynamic context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSecondaryContainer.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(Icons.subway),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Metro Ticket",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Book your journey with ease",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 30),
      Text(
        "Select Your Route",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    ],
  );
}
