import 'package:flutter/material.dart';
import 'package:metro_guide/generated/l10n.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).instructions),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildInstructionCard(
            context,
            S.of(context).operating_hours,
            S.of(context).hours,
            Icons.access_time,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            S.of(context).ticketing,
            S.of(context).ticketing_desc,
            Icons.credit_card,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            S.of(context).safety_guidelines,
            S.of(context).safety_guidelines_desc,
            Icons.security,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            S.of(context).prohibited_actions,
            S.of(context).prohibited_actions_desc,
            Icons.block,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            S.of(context).emergency_contacts,
            S.of(context).emergency_contacts_desc,
            Icons.emergency,
          ),
          const SizedBox(height: 10),
          _buildInstructionCard(
            context,
            S.of(context).accessibility,
            S.of(context).accessibility_desc,
            Icons.accessible,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
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
              color: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer.withOpacity(0.2),
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
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.7),
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
