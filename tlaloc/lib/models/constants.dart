import 'package:flutter/material.dart';

/// Para agregar o quitar parajes, basta con cambiar esta variable
Map<String, String> parajes = {
  'El Venturero': 'Nativitas',
  'El Jardín': 'Nativitas',
  'Cabaña': 'San Pablo Ixayoc',
  'Cruz de Zacatenco': 'San Dieguito',
  'Canoas altas': 'Tequexquinahuac',
  'Los Manantiales': 'Tequexquinahuac',
  'Terreno de Don Domingo': 'Santa Catarina del Monte',
  'Agua de Chiqueros': 'Santa Catarina del Monte',
};

final dateLongAgo = DateTime(2022, 1, 1);
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
