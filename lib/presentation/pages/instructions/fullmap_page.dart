import 'package:flutter/material.dart';
import 'package:metro_guide/generated/l10n.dart';

class FullMapPage extends StatelessWidget {
  const FullMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).metro_map),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
      body: InteractiveViewer(
        maxScale: 5.0,
        minScale: 0.5,
        child: Center(
          child: Image.asset('assets/images/map.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
