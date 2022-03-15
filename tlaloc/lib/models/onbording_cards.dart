import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/screens/navigation_bar.dart';

class CardPlanetData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color buttonColor;
  final Icon icon;
  final Widget? background;
  final bool? button;

  CardPlanetData(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      this.background,
      required this.buttonColor,
      required this.icon,
      this.button});
}

class CardPlanet extends StatelessWidget {
  const CardPlanet({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CardPlanetData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (data.background != null) data.background!,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Flexible(
                flex: 20,
                child: Image(image: data.image),
              ),
              const Spacer(flex: 5),
              AutoSizeText(
                data.title.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'FredokaOne',
                  color: data.titleColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                maxLines: 1,
              ),
              const Spacer(flex: 1),
              AutoSizeText(
                data.subtitle,
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: data.subtitleColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Spacer(flex: 15),
              if (data.button != null && data.button!)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      label: const AutoSizeText('¡Empezar ahora!',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      icon: data.icon,
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.green1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: data.button == true
                          ? () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) {
                                return const BottomNavBar();
                              }), (Route<dynamic> route) => false);
                            }
                          : null,
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
