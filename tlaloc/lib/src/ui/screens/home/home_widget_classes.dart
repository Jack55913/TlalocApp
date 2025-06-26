// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:url_launcher/url_launcher.dart';

import 'package:tlaloc/src/models/constants.dart';

class ContactUsListTile extends StatelessWidget {
  const ContactUsListTile({
    super.key,
    required this.title,
    required this.message,
    required this.title2,
  });

  final String title;
  final String message;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => launchUrl(Uri.parse(message)),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: CircleAvatar(
          backgroundColor: AppColors.whatsappGreen,
          child: const FaIcon(
            FontAwesomeIcons.whatsapp,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontFamily: 'FredokaOne'),
        textAlign: TextAlign.left,
      ),
      subtitle: Text(
        title2,
        // '+52 5630908507',
        style: TextStyle(
          fontFamily: 'poppins',
          // fontSize: 16,
          // letterSpacing: 2,
        ),
      ),
    );
  }
}
