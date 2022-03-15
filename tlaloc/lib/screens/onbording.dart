// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/onbording_cards.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatelessWidget {
  Onboarding({Key? key}) : super(key: key);

  final List<CardPlanetData> data = [
    CardPlanetData(
        title: "Tláloc App",
        subtitle: "¡Vamos a conservar y proteger nuestro monte!",
        image: const AssetImage("assets/images/img-1.png"),
        backgroundColor: AppColors.blue1,
        titleColor: Colors.white,
        subtitleColor: Colors.white,
        background: LottieBuilder.asset("assets/animation/bg-1.json"),
        button: false,
        icon: Icon(
          Icons.arrow_forward,
          color: Colors.transparent,
        ),
        buttonColor: Colors.transparent),
    CardPlanetData(
        title: "Selecciona un Ejido",
        subtitle: "¿A qué ejido perteneces?",
        image: const AssetImage("assets/images/img-2.png"),
        backgroundColor: Colors.white,
        titleColor: Colors.purple,
        subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
        background: LottieBuilder.asset("assets/animation/bg-2.json"),
        button: false,
        icon: Icon(
          Icons.arrow_forward,
          color: Colors.transparent,
        ),
        buttonColor: Colors.transparent),
    CardPlanetData(
      title: "Listo, Teresa",
      subtitle: "       ¡Vamos a salvar el monte Tlaloc!",
      image: const AssetImage("assets/images/img-3.png"),
      backgroundColor: const Color.fromRGBO(8, 26, 48, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-3.json"),
      button: true,
      icon: //inserta un icono:
          Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      buttonColor: AppColors.green1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index, double value) {
          return CardPlanet(data: data[index]);
        },
      ),
    );
  }
}
