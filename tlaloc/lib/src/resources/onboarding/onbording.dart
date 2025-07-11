import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/cards/onbording_cards.dart';
import 'package:tlaloc/src/resources/onboarding/sign_in.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final List<CardPlanetData> data = [
    CardPlanetData(
      title: appName,
      subtitle: "Ciencia para tí y para todos",
      image: const AssetImage("assets/images/img-1.png"),
      backgroundColor: AppColors.blue1,
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "Te damos la bienvenida",
      subtitle:
          "Ya eres parte del proyecto ''Ciencia ciudadana para el monitoreo de la lluvia en el monte Tláloc'' ",
      image: const AssetImage("assets/images/img-2.png"),
      backgroundColor: Colors.white,
      titleColor: AppColors.green1,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        direction: Axis.horizontal,
        pageSnapping: true,

        onFinish: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpWidget()),
          );
        },
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
      ),
    );
  }
}
