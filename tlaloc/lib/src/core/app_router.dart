import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/conditional_onboarding_page.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/resources/onboarding/onbording.dart';
import 'package:tlaloc/src/resources/statics/graphs/graph2.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';
import 'package:tlaloc/src/ui/screens/dir/data.dart';
import 'package:tlaloc/src/ui/screens/home/profile_page.dart';
import 'package:tlaloc/src/ui/screens/settings/community.dart';
import 'package:tlaloc/src/ui/screens/settings/credits.dart';
import 'package:tlaloc/src/ui/screens/settings/info.dart';
import 'package:tlaloc/src/ui/screens/settings/politics.dart';
import 'package:tlaloc/src/ui/screens/settings/privacy.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const ConditionalOnboardingPage(),
  '/credits': (context) => const CreditsPage(),
  '/politics': (context) => const PoliticPage(),
  '/privacy': (context) => const PrivacyPage(),
  '/info': (context) => const InfoProyectPage(),
  '/community': (context) => const CommunityPage(),
  '/home': (context) => const HomePage(),
  '/onboarding': (context) => Onboarding(),
  '/add': (context) => AddScreen(),
  '/data': (context) => const DataScreen(),
  '/graph': (context) => const BarGraph(),
  '/profile': (context) => const ConfigureScreen(),  
};



Route<dynamic> generateRoute(RouteSettings settings) {
  final builder = appRoutes[settings.name];

  if (builder != null) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide derecha a izquierda
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  // Ruta no encontrada
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: const Text('Error 404')),
      body: const Center(child: Text('Página no encontrada')),
    ),
  );
}