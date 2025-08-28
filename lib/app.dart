import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:metro_guide/generated/l10n.dart';
import 'package:metro_guide/presentation/navigationbar/navigationbar_page.dart'
    show NavigationbarPage;
import 'package:metro_guide/presentation/pages/welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginbefore = GetStorage().read("loginBefore") ?? false;
    final lang = GetStorage().read("lang") ?? 'en';
    final theme = GetStorage().read("theme") ?? 'dark';

    return GetMaterialApp(
      // localization
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      locale: lang == 'ar'
          ? const Locale('ar', 'EG')
          : const Locale('en', 'US'),
      // theme
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          onPrimaryContainer: Colors.red,
          onSecondaryContainer: Colors.redAccent,
          outline: Colors.grey[300],
          primaryContainer: Colors.grey[400],
          secondaryContainer: Colors.grey.shade400,
          scrim: Colors.grey[800],
        ),

        scaffoldBackgroundColor: Colors.grey[300],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.red[400], size: 28),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          onPrimaryContainer: Colors.blue,
          onSecondaryContainer: Colors.blueAccent,
          outline: Colors.grey[700],
          primaryContainer: Colors.grey[850],
          secondaryContainer: Colors.grey[800],
          scrim: Colors.orange,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.blue[400], size: 28),
      ),
      themeMode: theme == 'dark' ? ThemeMode.dark : ThemeMode.light,
      home: loginbefore ? NavigationbarPage() : WelcomePage(),
    );
  }
}
