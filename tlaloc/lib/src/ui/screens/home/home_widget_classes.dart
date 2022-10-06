// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/cards/tlalocmap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/cards/map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.whatsappgreen,
            surfaceTintColor: AppColors.whatsappgreen),
        onPressed: () {
          launchUrl(
              Uri.parse('https://api.whatsapp.com/send?phone=5634577396'));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
              SizedBox(
                width: 25,
              ),
              const SelectableText(
                '¡Contáctanos!',
                style: TextStyle(
                  fontFamily: 'FredokaOne',
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DynamicTlalocMap extends StatelessWidget {
  const DynamicTlalocMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TlalocMap()),
          );
        },
        child: DarkContainerWidget(
          data: DarkContainer(fill: TlalocMapData()),
        ));
  }
}
