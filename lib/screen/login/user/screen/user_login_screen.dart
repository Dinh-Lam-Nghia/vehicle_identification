import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/screen/login/user/provider/user_login_provider.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final UserLoginProvider _provider = UserLoginProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserLoginProvider>(
      create: ((context) => _provider),
      builder: (context, child) {
        return Consumer<UserLoginProvider>(
            builder: (context, provider, widget) {
          Future.delayed(Duration.zero, () {
            if (provider.user != null) {
              print(provider.user!.displayName);
            }
          });
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('User login'),
                ElevatedButton(
                    onPressed: () {
                      provider.loginWithGoogle();
                    },
                    child: const Text('login Goole'))
              ],
            )),
          );
        });
      },
    );
  }
}
