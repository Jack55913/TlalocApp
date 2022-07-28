import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/resources/onboarding/onbording.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';

class SplashScreen extends StatelessWidget {
  final Widget nextScreen;

  const SplashScreen({Key? key, required this.nextScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 500,
      backgroundColor: AppColors.dark1,
      splashTransition: SplashTransition.fadeTransition,
      splash: Image.asset(
        'assets/images/tlaloc_logo.png',
        fit: BoxFit.cover,
      ),
      nextScreen: nextScreen,
    );
  }
}

class ConditionalOnboardingPage extends StatelessWidget {
  const ConditionalOnboardingPage({Key? key}) : super(key: key);

  Future<bool> get hasFinishedOnboarding async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasFinishedOnboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasFinishedOnboarding,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool hasFinishedOnboarding = snapshot.data!;
          if (hasFinishedOnboarding) {
            return const HomePage();
          } else {
            return SplashScreen(nextScreen: Onboarding());
          }
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Ocurrió un error',
                style: TextStyle(
                  fontFamily: 'FredokaOne',
                ),
              ),
            ),
            body: EmptyState(
                'Intenta liberar espacio en tu dispositivo. Si el error persiste, manda correo a tlloc@googlegroups.com. El error es ${snapshot.error}'),
          );
        } else {
          return Center(
            child: Container(),
          );
        }
      },
    );
  }
}
