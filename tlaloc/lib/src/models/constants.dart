import 'package:flutter/material.dart';

/// Para agregar o quitar parajes, basta con cambiar esta variable
///
///
Map<String, String> parajes = {
  'El Venturero': 'Nativitas',
  'El Jardín': 'Nativitas',
  'Cabaña': 'San Pablo Ixayoc',
  'Cruz de Atenco': 'San Dieguito',
  'Canoas altas': 'San Dieguito',
  'Los Manantiales': 'Tequexquinahuac',
  'Tlaltlatlately': 'Santa Catarina del Monte',
  'Agua de Chiqueros': 'Santa Catarina del Monte',
};

Map<String, Widget> roles = {
  'Visitante': const Icon(Icons.person_search),
  'Monitor': const Icon(Icons.star),
};

List<String> commonimages = [
  "assets/images/1_venturero.png",
  "assets/images/2_jardin.png",
  "assets/images/3_cabana.png",
  "assets/images/4_cruz.png",
  "assets/images/5_canoas.png",
  "assets/images/6_manantiales.png",
  "assets/images/7_terreno.png",
  "assets/images/8_chiqueros.png",
];

List<String> parajecolection = [
  'El Venturero',
  'El Jardín',
  'Cabaña',
  'Cruz de Atenco',
  'Canoas altas',
  'Los Manantiales',
  'Tlaltlatlately',
  'Agua de Chiqueros'
];

List<String> ejidocolection = [
  'Nativitas',
  'Nativitas',
  'San Pablo Ixayoc',
  'San Dieguito',
  'San Dieguito',
  'Tequexquinahuac',
  'Santa Catarina del Monte',
  'Santa Catarina del Monte',
];

// Iterator itr = commonimages.iterator;

Map<String, Widget> cuentas = {
  'Visitante': const Icon(Icons.person_search, size: 30), //Key
  'Monitor': const Icon(Icons.star, size: 30), //value
};

final dateLongAgo = DateTime(2022, 1, 1);
final dateInALongTime = DateTime(3000, 12, 31);

String appName = 'Tláloc App';

class AppColors {
  // From dark illustration
  static const Color dark1 = Color(0xFF121212);
  static const Color dark3 = Color(0xFF181818);
  static const Color dark2 = Color(0xFF212121);
  static const Color gray1 = Color(0xFF828690);
  static const Color blue1 = Color(0xFF00AEEF);
  static const Color green1 = Color(0xFF00E583);
  static const Color red1 = Color(0xFFB01235);
  static const Color whatsappgreen = Color(0xFF25D366);

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
    elevation: 0,
    backgroundColor: AppColors.dark2,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: AppColors.dark2,
);
