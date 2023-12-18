import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/screen/home/screen/admin_home_screen.dart';
import 'package:vehicle_identification/app/admin/screen/login/provider/provider.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/app/utils/app_image.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_button.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final AdminLoginProvider _provider = AdminLoginProvider();

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      large: AdminLogin(
        isSmall: false,
        provider: _provider,
      ),
      small: AdminLogin(
        isSmall: true,
        provider: _provider,
      ),
      medium: AdminLogin(
        isSmall: false,
        provider: _provider,
      ),
    );
  }
}

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key, required this.isSmall, required this.provider});
  final bool isSmall;
  final AdminLoginProvider provider;

  @override
  Widget build(BuildContext context) {
    double width(Size size) {
      return isSmall ? size.width * 0.9 : size.width * 0.4;
    }

    final TextEditingController _controller = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AdminLoginProvider>(
      create: ((context) => provider),
      builder: (context, child) {
        return Consumer<AdminLoginProvider>(builder: (context, p, widget) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).nameApp,
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontSize: 40,
                          fontFamily: 'CarterOne',
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        AppImage.imgCarHome,
                        height: size.height * 0.4,
                        width: size.width * 0.4,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppInput(
                          controller: _controller,
                          labelText: S.of(context).account,
                          width: width(size)),
                      const SizedBox(
                        height: 20,
                      ),
                      AppInput(
                          controller: _controller,
                          labelText: S.of(context).password,
                          width: width(size)),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                          width: width(size),
                          text: S.of(context).login.toUpperCase(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminHomeScreen()));
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
