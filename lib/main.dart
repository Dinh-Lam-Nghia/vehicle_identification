import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/screen/home/screen/admin_home_screen.dart';
import 'package:vehicle_identification/firebase_options.dart';
import 'package:vehicle_identification/app/user/screen/add_vehicle/provider/add_vehicle_provider.dart';
import 'package:vehicle_identification/app/user/screen/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vehicle_identification/app/utils/app_provider.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          ChangeNotifierProvider(create: (context) => AddVehicleProvider()),
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
              useMaterial3: false,
              // fontFamily: 'CarterOne'
            ),
            home: const SplashScreen(),
          ),
        ));
  }
}
