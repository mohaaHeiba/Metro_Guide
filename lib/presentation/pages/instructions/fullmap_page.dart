
import 'package:flutter/material.dart';

class FullMapPage extends StatelessWidget {
  const FullMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Full Metro Map',
      
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSecondaryContainer),
      ),
      body: InteractiveViewer(
        maxScale: 5.0,
        minScale: 0.5,
        child: Center(
          child: Image.asset(
            'assets/images/map.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

