import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:metro_guide/presentation/pages/instructions/Instructions_page.dart';
import 'package:metro_guide/presentation/pages/instructions/fullmap_page.dart';
import 'package:metro_guide/presentation/widgets/map_widgets/infocars_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(),
              const SizedBox(height: 20),

              // Map container
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InteractiveViewer(
                    child: Image.asset(
                      'assets/images/map.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Action buttons section
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      'View Full Map',
                      Icons.map,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      'Instructions',
                      Icons.info_outline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Quick info cards
              Column(
                children: [
                  infocardWidget(
                    context,
                    'Operating Hours',
                    '5:00 AM - 12:00 AM',
                    Icons.access_time,
                  ),
                  const SizedBox(height: 10),
                  infocardWidget(
                    context,
                    'Service Status',
                    'All lines operational',
                    Icons.check_circle,
                  ),
                  const SizedBox(height: 10),
                  infocardWidget(
                    context,
                    'Last Updated',
                    'Just now',
                    Icons.update,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String text, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'View Full Map') {
          Get.to(const FullMapPage(), transition: Transition.downToUp);
        } else {
          Get.to(const InstructionsPage(), transition: Transition.downToUp);
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
