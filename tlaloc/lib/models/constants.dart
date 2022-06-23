import 'package:flutter/material.dart';

/// Para agregar o quitar ejidos, basta con cambiar esta variable
/// TODO: poner el número de hectáreas.
Map<String, num> ejidos = {
  'Tequexquinahuac': 1200,
  'San Dieguito Xuhimanca': 99999,
  'San Pablo Ixayoc': 99999,
  'San Juan Totolapan': 99999,
  'San Miguel Tlaixpan': 99999,
  'Nativitas': 99999,
};

final dateLongAgo = DateTime(2000, 1, 1);
final dateInALongTime = DateTime(3000, 12, 31);

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
  static const Color dark1 = Color(0xFF121212);
  static const Color dark3 = Color(0xFF181818);
  static const Color dark2 = Color(0xFF212121);
  static const Color gray1 = Color(0xFF828690);
  static const Color blue1 = Color(0xFF00AEEF);
  static const Color green1 = Color(0xFF00E583);
  static const Color red1 = Color(0xFFB01235);

  // From light illustration
  static const Color pruple1 = Color(0xFF2C2A6B);
  static const Color purple2 = Color(0xFF345E9D);
  static const Color orange1 = Color(0xFFE6473A);
  static const Color lightBlue = Color(0xFF50A8AE);
  static const Color blue3 = Color(0xFF081A30);
}

ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  primaryColor: AppColors.dark1,
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
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
  appBarTheme: const AppBarTheme(
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
