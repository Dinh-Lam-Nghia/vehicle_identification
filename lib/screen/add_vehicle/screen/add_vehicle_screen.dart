import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/screen/add_vehicle/provider/add_vehicle_provider.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_otp.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddVehicleScreen> {
  final AddVehicleProvider _provider = AddVehicleProvider();
  
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _controller = TextEditingController();

  Future<void> _showMyDialogOTP(AddVehicleProvider p) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: AppOTP(
            onSubmit: (value) {
              FirebaseAuth auth = FirebaseAuth.instance;
              var credential = PhoneAuthProvider.credential(
                  verificationId: p.verificationId, smsCode: value);
              auth.signInWithCredential(credential).then((result) {
                p.setVerify();
                Navigator.pop(context);
              }).catchError((e) {});
            },
            codeVetify: p.smsCodeController.text.trim(),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Resend"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _iconVerify(AddVehicleProvider p) {
    return IconButton(
        onPressed: () {
          p.verifyPhone(context);
        },
        icon: Icon(
          Icons.verified,
          color: p.isVerify ? AppColor.successColor : AppColor.red,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AddVehicleProvider>(
      create: (_) => _provider,
      builder: (context, widgets) {
        return Consumer<AddVehicleProvider>(
            builder: (context, provider, child) {
          Future.delayed(Duration.zero, () {
            if (provider.isCodeSent) {
              _showMyDialogOTP(provider);
            }
          });
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              elevation: 0,
              title: Text(
                S.of(context).addVehicle.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    AppInput(
                        controller: _controller,
                        width: size.width * 0.9,
                        labelText: S.of(context).model),
                    const SizedBox(
                      height: 20,
                    ),
                    AppInput(
                        controller: provider.phoneController,
                        
                        width: size.width * 0.9,
                        keyboardType: TextInputType.phone,
                        onChange: provider.checkPhoneFilled,
                        labelText: S.of(context).phone,
                        suffixIcon: _iconVerify(provider)),
                    const SizedBox(
                      height: 20,
                    ),
                    AppInput(
                        controller: _controller,
                        width: size.width * 0.9,
                        labelText: S.of(context).vehicleId),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
