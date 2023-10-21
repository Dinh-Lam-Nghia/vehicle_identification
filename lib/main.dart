import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/screen/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vehicle_identification/utils/app_provider.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AppProvider(),
          ),
        ],
        child: Consumer<AppProvider>(
          builder: (ctx, app, _) => MaterialApp(
            title: 'Campus Car',
            locale: app.currentLocale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          ),
        ));
  }
}
