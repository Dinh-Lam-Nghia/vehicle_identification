import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/utils/app_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.read<AppProvider>().changeLocale();
            },
            child: Text(S.of(context).language)),
      ),
    );
  }
}
