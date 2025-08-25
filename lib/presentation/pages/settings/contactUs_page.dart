import 'package:flutter/material.dart';
import 'package:metro_guide/presentation/widgets/custom_widgets/snackbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email_outlined, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Need Help?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You can reach us via email anytime. We will get back to you as soon as possible.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Send Email'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'mohamedheiba88998@gmail.com',
                  query:
                      'subject=Support Request&body=Hello, I need help with...',
                );
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                } else {
                  showSnackBar("Error", "could not lunch Email", Colors.red);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
