// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Campus Car`
  String get nameApp {
    return Intl.message(
      'Campus Car',
      name: 'nameApp',
      desc: '',
      args: [],
    );
  }

  /// `test`
  String get test {
    return Intl.message(
      'test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN WITH GOOGLE`
  String get loginWithGoogle {
    return Intl.message(
      'LOGIN WITH GOOGLE',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `CHOOSE ANOTHER ACCOUNT`
  String get chooseAnotherAccount {
    return Intl.message(
      'CHOOSE ANOTHER ACCOUNT',
      name: 'chooseAnotherAccount',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE WITH THIS ACCOUNT`
  String get continueWithThisAccount {
    return Intl.message(
      'CONTINUE WITH THIS ACCOUNT',
      name: 'continueWithThisAccount',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Add vehicle`
  String get addVehicle {
    return Intl.message(
      'Add vehicle',
      name: 'addVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle information`
  String get vehicleInfor {
    return Intl.message(
      'Vehicle information',
      name: 'vehicleInfor',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Expires`
  String get expires {
    return Intl.message(
      'Expires',
      name: 'expires',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Type vehicle`
  String get typeVehicle {
    return Intl.message(
      'Type vehicle',
      name: 'typeVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Black gray`
  String get blackGray {
    return Intl.message(
      'Black gray',
      name: 'blackGray',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe by month`
  String get roleSubMonth {
    return Intl.message(
      'Subscribe by month',
      name: 'roleSubMonth',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe by day`
  String get roleSubDate {
    return Intl.message(
      'Subscribe by day',
      name: 'roleSubDate',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Motorbike`
  String get motorbike {
    return Intl.message(
      'Motorbike',
      name: 'motorbike',
      desc: '',
      args: [],
    );
  }

  /// `Car`
  String get car {
    return Intl.message(
      'Car',
      name: 'car',
      desc: '',
      args: [],
    );
  }

  /// `Click here for more vehicle information!`
  String get onTapAddVehicle {
    return Intl.message(
      'Click here for more vehicle information!',
      name: 'onTapAddVehicle',
      desc: '',
      args: [],
    );
  }

  /// `License plates`
  String get vehicleId {
    return Intl.message(
      'License plates',
      name: 'vehicleId',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verifyOTP {
    return Intl.message(
      'Verify OTP',
      name: 'verifyOTP',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format!`
  String get invalidFormat {
    return Intl.message(
      'Invalid format!',
      name: 'invalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number!`
  String get enterPhoneNumber {
    return Intl.message(
      'Please enter phone number!',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number verified!`
  String get verifiedPhoneNumber {
    return Intl.message(
      'Phone number verified!',
      name: 'verifiedPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Input OTP`
  String get inputOTP {
    return Intl.message(
      'Input OTP',
      name: 'inputOTP',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Error OTP`
  String get errorOTP {
    return Intl.message(
      'Error OTP',
      name: 'errorOTP',
      desc: '',
      args: [],
    );
  }

  /// `Please wait!`
  String get pleaseWait {
    return Intl.message(
      'Please wait!',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Select color`
  String get selectColor {
    return Intl.message(
      'Select color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get localeDate {
    return Intl.message(
      'en',
      name: 'localeDate',
      desc: '',
      args: [],
    );
  }

  /// `Please verify phone number!`
  String get pleaseVerifyPhone {
    return Intl.message(
      'Please verify phone number!',
      name: 'pleaseVerifyPhone',
      desc: '',
      args: [],
    );
  }

  /// `All vehicles`
  String get allVehicle {
    return Intl.message(
      'All vehicles',
      name: 'allVehicle',
      desc: '',
      args: [],
    );
  }

  /// `License plate`
  String get licensePlate {
    return Intl.message(
      'License plate',
      name: 'licensePlate',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get changeLanguage {
    return Intl.message(
      'Change language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUS {
    return Intl.message(
      'About us',
      name: 'aboutUS',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Management vehicle`
  String get managementVehicle {
    return Intl.message(
      'Management vehicle',
      name: 'managementVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Data will be lost when you press the delete button!. Are you sure?`
  String get confirmDelete {
    return Intl.message(
      'Data will be lost when you press the delete button!. Are you sure?',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Deleted!`
  String get deleted {
    return Intl.message(
      'Deleted!',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `Update vehicle`
  String get updateVehicle {
    return Intl.message(
      'Update vehicle',
      name: 'updateVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Statistical`
  String get statistical {
    return Intl.message(
      'Statistical',
      name: 'statistical',
      desc: '',
      args: [],
    );
  }

  /// `All vehicles`
  String get totalVehicles {
    return Intl.message(
      'All vehicles',
      name: 'totalVehicles',
      desc: '',
      args: [],
    );
  }

  /// `Permit expired`
  String get permitExpired {
    return Intl.message(
      'Permit expired',
      name: 'permitExpired',
      desc: '',
      args: [],
    );
  }

  /// `Total out`
  String get totalOut {
    return Intl.message(
      'Total out',
      name: 'totalOut',
      desc: '',
      args: [],
    );
  }

  /// `Total in`
  String get totalIn {
    return Intl.message(
      'Total in',
      name: 'totalIn',
      desc: '',
      args: [],
    );
  }

  /// `Daily scan`
  String get dailyScan {
    return Intl.message(
      'Daily scan',
      name: 'dailyScan',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle location`
  String get vehicleLocation {
    return Intl.message(
      'Vehicle location',
      name: 'vehicleLocation',
      desc: '',
      args: [],
    );
  }

  /// `Inside`
  String get inside {
    return Intl.message(
      'Inside',
      name: 'inside',
      desc: '',
      args: [],
    );
  }

  /// `Outside`
  String get outside {
    return Intl.message(
      'Outside',
      name: 'outside',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle owner role`
  String get vehicleOwnerRole {
    return Intl.message(
      'Vehicle owner role',
      name: 'vehicleOwnerRole',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get staff {
    return Intl.message(
      'Staff',
      name: 'staff',
      desc: '',
      args: [],
    );
  }

  /// `Visitor`
  String get visitor {
    return Intl.message(
      'Visitor',
      name: 'visitor',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message(
      'Member',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `Other people`
  String get otherPeople {
    return Intl.message(
      'Other people',
      name: 'otherPeople',
      desc: '',
      args: [],
    );
  }

  /// `Upload image`
  String get uploadImage {
    return Intl.message(
      'Upload image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Verify vehicle`
  String get verifyVehicle {
    return Intl.message(
      'Verify vehicle',
      name: 'verifyVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Please take a camera or select image!`
  String get cameraOrFile {
    return Intl.message(
      'Please take a camera or select image!',
      name: 'cameraOrFile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
