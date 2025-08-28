import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Metro Instructions',
        
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSecondaryContainer),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildInstructionCard(
            context,
            'Operating Hours',
            '5:00 AM to 12:00 AM daily',
            Icons.access_time,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            'Ticketing',
            'Use contactless cards or tokens at entry gates',
            Icons.credit_card,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            'Safety Guidelines',
            'Stand behind the yellow line, hold the handrail on escalators',
            Icons.security,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            'Prohibited Actions',
            'Smoking, carrying flammable materials, and vandalism are prohibited',
            Icons.block,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            'Emergency Contacts',
            'Call 911 for emergencies or use emergency phones on platforms',
            Icons.emergency,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            'Accessibility',
            'All stations are wheelchair accessible with elevators and ramps',
            Icons.accessible,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionCard(BuildContext context, String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
