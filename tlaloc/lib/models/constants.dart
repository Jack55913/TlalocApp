// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';

//FirebaseAnalytics analytics = FirebaseAnalytics();
// FirebaseAnalytics analytics = FirebaseAnalytics.instance;

String appName = 'Tláloc App';
const meses = <String>[
  'ene',
  'feb',
  'mar',
  'abr',
  'may',
  'jun',
  'jul',
  'ago',
  'sep',
  'oct',
  'nov',
  'dic'
];

class AppColors {
  // From dark illustration
  static Color dark1 = Color(0xFF121212);
  static Color dark3 = Color(0xFF181818);
  static Color dark2 = Color(0xFF212121);
  static Color gray1 = Color(0xFF828690);
  static Color blue1 = Color(0xFF00AEEF);
  static Color green1 = Color(0xFF00E583);
  static Color red1 = Color(0xFFB01235);

  // From light illustration
  static Color pruple1 = Color(0xFF2C2A6B);
  static Color purple2 = Color(0xFF345E9D);
  static Color orange1 = Color(0xFFE6473A);
  static Color lightBlue = Color(0xFF50A8AE);
  static Color blue3 = Color(0xFF081A30);
}

ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  primaryColor: AppColors.dark1,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.dark3,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: AppColors.dark1,
);

ThemeData newLightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.pink,
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.grey,
    ),
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  selectedRowColor: AppColors.orange1,
);
