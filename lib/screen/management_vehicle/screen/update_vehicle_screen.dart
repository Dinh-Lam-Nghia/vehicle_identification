import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/model/vehicle.dart';
import 'package:vehicle_identification/screen/add_vehicle/widget/otp_widget.dart';
import 'package:vehicle_identification/screen/add_vehicle/widget/select_color_widget.dart';
import 'package:vehicle_identification/screen/management_vehicle/provider/update_vehicle_provider.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/widget/app_button.dart';
import 'package:vehicle_identification/widget/app_dropdown.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class UpdateVehicleScreen extends StatefulWidget {
  const UpdateVehicleScreen({super.key, required this.vehicle});
  final Vehicle vehicle;
  @override
  State<UpdateVehicleScreen> createState() => _UpdateVehicleScreenState();
}

class _UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
  final UpdateVehicleProvider _provider = UpdateVehicleProvider();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _provider.init(widget.vehicle);
    super.initState();
  }

  Widget iconVerifyCar(UpdateVehicleProvider p) {
    return IconButton(
        onPressed: () {
          handleVerify(p);
        },
        icon: Icon(
          Icons.directions_car,
          color: p.isVerify ? AppColor.successColor : AppColor.red,
        ));
  }

  handleVerify(UpdateVehicleProvider p) {
    if (p.phoneController.text.isEmpty) {
      AppToast().showToast(S.of(context).enterPhoneNumber);
    } else if (p.phoneController.text.length < 12) {
      AppToast().showToast(S.of(context).invalidFormat);
    } else {
      if (!p.isVerify) {
        p.verifyPhone();
      } else {
        AppToast().showToast(S.of(context).verifiedPhoneNumber);
      }
    }
  }

  Widget iconVerifyPhone(UpdateVehicleProvider p) {
    return IconButton(
        onPressed: () {
          handleVerify(p);
        },
        icon: Icon(
          Icons.verified,
          color: p.isVerify ? AppColor.successColor : AppColor.red,
        ));
  }

  selectDate(UpdateVehicleProvider p) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: p.roleIndex == 0
            ? DateTime(DateTime.now().year, DateTime.now().month + 1,
                DateTime.now().day)
            : DateTime(DateTime.now().year + 1, DateTime.now().month + 6,
                DateTime.now().day),
        locale: Locale(
            S.of(context).localeDate, S.of(context).localeDate.toUpperCase()));
    p.setDate(picked);
    p.checkExpires();
  }

  openColorPicker(UpdateVehicleProvider p) {
    showDialog(
      context: context,
      builder: (_) {
        return SelectColorWidget(
            mainColor: p.mainColor!,
            setMainColor: p.setMainColor,
            setColor: p.setColor);
      },
    );
  }

  showMyDialogOTP(UpdateVehicleProvider p) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OtpWidget(
          codeVetify: p.smsCodeController.text.trim(),
          verificationId: p.verificationId,
          setVerify: p.setVerify,
          verifyPhone: p.verifyPhone,
          setSendCode: p.setSentCode,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => _provider,
      builder: (context, widgets) {
        return Consumer<UpdateVehicleProvider>(
            builder: (context, provider, child) {
          return Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                title: Text(
                  S.of(context).updateVehicle.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                        controller: provider.phoneController,
                        width: size.width * 0.9,
                        keyboardType: TextInputType.phone,
                        onChange: provider.checkPhoneFilled,
                        labelText: S.of(context).phone,
                        suffixIcon: iconVerifyPhone(provider)),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).role,
                            style: const TextStyle(fontSize: 16),
                          ),
                          AppDropdown(
                            listRole: [
                              S.of(context).roleSubDate,
                              S.of(context).roleSubMonth
                            ],
                            value: provider.roleContent.isEmpty
                                ? S.of(context).roleSubDate
                                : provider.roleContent,
                            onChanged: provider.setRole,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).color,
                            style: const TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              openColorPicker(provider);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: provider.mainColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).expires,
                            style: const TextStyle(fontSize: 16),
                          ),
                          InkWell(
                              onTap: () {
                                selectDate(provider);
                              },
                              child: Text(provider.dateRegister,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: provider.isCheckExpires
                                          ? AppColor.successColor
                                          : AppColor.errorColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: provider.isCheckExpires
                                          ? AppColor.successColor
                                          : AppColor.errorColor)))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppButton(
                        width: size.width * 0.9,
                        text: S.of(context).update,
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              provider.isVerify) {
                          } else if (provider.isVerify) {
                            AppToast()
                                .showToast(S.of(context).pleaseVerifyPhone);
                          }
                        }),
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
