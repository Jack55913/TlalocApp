// lib/src/ui/screens/conditional_onboarding.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/resources/onboarding/onbording.dart'; 
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/splash.dart'; 

class ConditionalOnboardingPage extends StatelessWidget {
  const ConditionalOnboardingPage({super.key});

  Future<Widget> _decideNextScreen(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final hasFinishedOnboarding = prefs.getBool('hasFinishedOnboarding') ?? false;

    final authProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final isLoggedIn = authProvider.currentUser != null;

    if (hasFinishedOnboarding && isLoggedIn) {
      return const HomePage();
    } else {
      return Onboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _decideNextScreen(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const _ErrorScreen();
        } else if (snapshot.connectionState != ConnectionState.done) {
          // Evita pantalla en blanco, mientras resuelve
          return const SplashScreen(nextScreen: Scaffold());
        } else {
          return SplashScreen(nextScreen: snapshot.data!);
        }
      },
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error de inicio')),
      body: const EmptyState(
        'No pudimos cargar la configuración inicial. '
        'Por favor revisa tu conexión a internet o reinstala la aplicación.',
      ),
    );
  }
}
