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

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
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

  /// `Subscribe by date`
  String get roleSubDate {
    return Intl.message(
      'Subscribe by date',
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
