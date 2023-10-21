import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/utils/app_provider.dart';

import '../../generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).hello),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.read<AppProvider>().changeLocale();
            },
            child: const Text('Hello')),
      ),
    );
  }
}
