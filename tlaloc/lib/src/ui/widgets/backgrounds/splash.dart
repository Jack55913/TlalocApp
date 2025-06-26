// lib/src/ui/widgets/backgrounds/splash_screen.dart

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class SplashScreen extends StatelessWidget {
  final Widget nextScreen;

  const SplashScreen({super.key, required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 800,
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
