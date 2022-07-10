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
            // Espacio entre ambas
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 1,
              ),
              Column(
                children: const [
                  Text(
                    'Descúbre un grupo\npara preservar\nel monte Tláloc',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Explora las acciones y\núnan fuerzas ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: const [
                  Image(
                    image: AssetImage('assets/images/img-5.jpg'),
                    fit: BoxFit.cover,
                    width: 150,
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
