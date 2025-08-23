import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget dropDown(Icon icon, BuildContext context, bool appearIcon2) {
  return SizedBox(
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: DropdownMenu(
              dropdownMenuEntries: [],
              width: double.infinity,
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        appearIcon2
            ? IconButton(onPressed: () {}, icon: Icon(Icons.my_location))
            : SizedBox(),
        IconButton(onPressed: () {}, icon: icon),
      ],
    ),
  );
}
