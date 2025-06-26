import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardPlanetData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  CardPlanetData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background,
  });
}

class CardPlanet extends StatelessWidget {
  const CardPlanet({
    required this.data,
    super.key,
  });

  final CardPlanetData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          if (data.background != null) data.background!,
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
