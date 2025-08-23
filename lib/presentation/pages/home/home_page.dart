import 'package:flutter/material.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/dropdown_widget.dart';
import 'package:metro_guide/presentation/widgets/home_widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 15,
          children: [
            headerWidget(context),
            SizedBox(height: 1),
            dropDown(Icon(Icons.location_on), context, true),
            dropDown(Icon(Icons.location_on_outlined), context, false),
          ],
        ),
      ),
    );
  }
}
