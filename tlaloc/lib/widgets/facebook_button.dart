import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.orange1,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Descúbre un grupo\npara preservar\nel monte Tláloc',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Explora las acciones y\núnan fuerzas ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                // Alinear a la derecha:
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Image(
                      image: AssetImage('assets/images/img-5.jpg'),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 150,
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // analytics.logEvent(name: 'view-facebook');
        launchUrl(
          Uri.parse(
              'https://www.facebook.com/Ciencia-Ciudadana-para-el-Monitoreo-de-Lluvia-100358326014423'),
          mode: LaunchMode.externalApplication,
        );
      },
    );
  }
}
