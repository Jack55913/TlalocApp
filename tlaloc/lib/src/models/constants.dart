import 'package:flutter/material.dart';
// import 'package:tlaloc/src/resources/statics/charts/chart3.dart';
import 'package:tlaloc/src/resources/statics/charts/chart4.dart';
import 'package:tlaloc/src/resources/statics/graphs/graph1.dart';
import 'package:tlaloc/src/resources/statics/graphs/graph2.dart';
import 'package:tlaloc/src/resources/statics/graphs/graph3.dart';
import 'package:tlaloc/src/resources/statics/graphs/graph4.dart';
// import 'package:tlaloc/src/resources/statics/graphs/graph5.dart';
// import 'package:tlaloc/src/resources/statics/graphs/graph7.dart';
// import 'package:tlaloc/src/resources/statics/graphs/graph9.dart';
// import 'package:tlaloc/src/resources/statics/graphs/grpah8.dart';

List<Icon> graphIcons = [
  Icon(Icons.show_chart, color: Colors.blue[300]),
  Icon(Icons.area_chart, color: Colors.green[300]),
  Icon(Icons.bar_chart, color: Colors.red[300]),
  Icon(Icons.bubble_chart_rounded, color: Colors.orange[300]),
  Icon(Icons.pie_chart, color: Colors.purple[300]),
  Icon(Icons.stacked_line_chart_rounded, color: Colors.pink[300]),
  Icon(Icons.line_axis, color: Colors.amber[300]),
  Icon(Icons.bar_chart, color: Colors.indigo[300]),
  Icon(Icons.stacked_bar_chart_rounded, color: Colors.teal[300]),
  Icon(Icons.area_chart_outlined, color: Colors.yellow[300]),
];

List<Color> grpahIconColor = [
  const Color.fromARGB(255, 0, 43, 79),
  const Color.fromARGB(255, 0, 66, 2),
  const Color.fromARGB(255, 62, 4, 0),
  const Color.fromARGB(255, 59, 36, 0),
  const Color.fromARGB(255, 52, 0, 61),
  const Color.fromARGB(255, 69, 0, 23),
  const Color.fromARGB(255, 180, 160, 10),
  const Color.fromARGB(255, 23, 3, 95),
  const Color.fromARGB(255, 2, 134, 132),
  const Color.fromARGB(255, 163, 155, 1),
];

List<String> graphtitle = [
  "De Dispersión",
  "De Volúmenes",
  "De Barras",
  "De Burbujas",
  "De Pasteles",
  "De Disperción (Comparación de Ejidos)",
  "De Disperción interactivo (Comparación de Ejidos)",
  "De Barras (Comparación de Ejidos por fecha)",
  "De Barras (Comparación de Ejidos)",
  "De Volúmenes (Comparación de Ejidos)",
];
final graphscrens = [
  const DispersionBar(),
  const VolumenGraph(),
  const BarGraph(),
  const BubbleGraph(),
  const PieChartTooltip(key: Key('pie_chart_tooltip')),
  // const CommonsLineGraph(),
  // const TrackballGraph(),
  // const MultipleCommonSeries(),
  // const StackedColumnChart(),
  // const CommonAreaSeries(),
];

/// Para agregar o quitar parajes, basta con cambiar esta variable

Map<String, String> parajes = {
  'El Venturero': 'Nativitas',
  'El Jardín': 'Nativitas',
  'Cabaña': 'San Pablo Ixayoc',
  'Cruz de Atenco': 'San Dieguito',
  'Canoas altas': 'San Dieguito',
  'Los Manantiales': 'Tequexquinahuac',
  'Tlaltlatlately': 'Santa Catarina del Monte',
  'Agua de Chiqueros': 'Santa Catarina del Monte',
  'Camino a las Trancas': 'Nativitas',
  'El Cedral': 'San Pablo Ixayoc',
  'Tlachichilpa': 'San Dieguito',
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
  "assets/images/9_trancas.png",
  "assets/images/10_cedral.png",
  "assets/images/11_Tlalchichilpa.png",
];

List<String> parajecolection = [
  'El Venturero',
  'El Jardín',
  'Cabaña',
  'Cruz de Atenco',
  'Canoas altas',
  'Los Manantiales',
  'Tlaltlatlately',
  'Agua de Chiqueros',
  'Camino a las Trancas',
  'El Cedral',
  'Tlachichilpa',
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
  'Nativitas', //TODO: Cambiar
  'San Pablo Ixayoc',
  'San Dieguito',
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
  // Oscuros
  static const Color dark1 = Color(0xFF121212);
  static const Color dark2 = Color(0xFF181818);
  static const Color dark3 = Color(0xFF212121);

  // Neutros y acentos
  static const Color gray1 = Color(0xFF828690);
  static const Color blue1 = Color(0xFF00AEEF);
  static const Color green1 = Color(0xFF00E583);
  static const Color red1 = Color(0xFFB01235);
  static const Color whatsappGreen = Color(0xFF25D366);

  // Ilustrativos
  static const Color purple1 = Color(0xFF2C2A6B);
  static const Color purple2 = Color(0xFF345E9D);
  static const Color orange1 = Color(0xFFE6473A);
  static const Color lightBlue = Color(0xFF50A8AE);
  static const Color blue3 = Color(0xFF081A30);
}

final ThemeData appDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.blue1,
    onPrimary: Colors.white,
    secondary: AppColors.green1,
    onSecondary: Colors.black,
    error: AppColors.red1,
    onError: Colors.white,
    surface: Colors.white10,
    onSurface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.dark3,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  scaffoldBackgroundColor: AppColors.dark2,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
);

final ThemeData appLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.blue3,
    onPrimary: Colors.white,
    secondary: AppColors.orange1,
    onSecondary: Colors.white,
    error: AppColors.red1,
    onError: Colors.white,
    surface: Color(0xFFF5F5F5),
    onSurface: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  scaffoldBackgroundColor: Colors.grey.shade50,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
);

class SectionTitle extends StatelessWidget {
  final String text;
  final double fontSize;

  const SectionTitle({super.key, required this.text, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Poppins',
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
