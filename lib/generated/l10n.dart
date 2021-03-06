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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hello`
  String get title {
    return Intl.message(
      'hello',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get REPORT {
    return Intl.message(
      '',
      name: 'REPORT',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get BRANCH {
    return Intl.message(
      '',
      name: 'BRANCH',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get VIOLATION {
    return Intl.message(
      '',
      name: 'VIOLATION',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get HOME_LATEST_NOTIFICATION {
    return Intl.message(
      '',
      name: 'HOME_LATEST_NOTIFICATION',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get HOME_SEE_ALL {
    return Intl.message(
      '',
      name: 'HOME_SEE_ALL',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get HOME_REPORT_LIST {
    return Intl.message(
      '',
      name: 'HOME_REPORT_LIST',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get HOME_VIOLATION_LIST {
    return Intl.message(
      '',
      name: 'HOME_VIOLATION_LIST',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get VIOLATION_CARD {
    return Intl.message(
      '',
      name: 'VIOLATION_CARD',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get LANGUAGE {
    return Intl.message(
      '',
      name: 'LANGUAGE',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get LANGUAGE_VN {
    return Intl.message(
      '',
      name: 'LANGUAGE_VN',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get LANGUAGE_EN {
    return Intl.message(
      '',
      name: 'LANGUAGE_EN',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get CHANGE_PASSWORD {
    return Intl.message(
      '',
      name: 'CHANGE_PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get LOGOUT {
    return Intl.message(
      '',
      name: 'LOGOUT',
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
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}