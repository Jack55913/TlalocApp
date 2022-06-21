// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/screens/home.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class CommonSelectPage extends StatelessWidget {
  const CommonSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple2,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Selecciona un Ejido',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FredokaOne',
                        color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '¿A qué ejido perteneces?',
                    style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                        color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      QrSelectWidget(),
                      CommonSelectWidget(
                        ejido: 'Tequexquinahuac',
                        hectareas: 1200,
                      ),
                      CommonSelectWidget(
                        ejido: 'San Dieguito',
                        hectareas: 99999,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonSelectWidget extends StatelessWidget {
  final String ejido;
  final int hectareas;

  const CommonSelectWidget(
      {Key? key, required this.ejido, required this.hectareas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),

      /// TODO: el inkwell no muestra el efecto cuando lo tocas. creo que es un bug
      /// demasiado menor para arreglar pero yo sí lo noto
      child: InkWell(
          onTap: () async {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return const HomePage();
            }), (Route<dynamic> route) => false);
            var prefs = await SharedPreferences.getInstance();
            prefs.setString('ejido', ejido);
            prefs.setBool('hasFinishedOnboarding', true);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // Insert circle image here:
                  CircleAvatar(
                    backgroundColor: AppColors.orange1,
                    radius: 50,
                    child: Icon(
                      FontAwesomeIcons.t,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    ejido,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontFamily: 'FredokaOne',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$hectareas Ha',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class QrSelectWidget extends StatelessWidget {
  const QrSelectWidget({Key? key}) : super(key: key);

// String qrValue = "Codigo Qr";

// void scanQr() async {
//   String cameraScanResult = await scanner.scan();
//   setState(() {
//     qrValue = cameraScanResult;
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
          // onPressed: () => scanQr(),
          child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // Insert circle image here:
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/qr_code.png'),
                radius: 50,
              ),
              SizedBox(height: 5),
              Text(
                'QR',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontFamily: 'FredokaOne',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Detecta tu pluviómetro automáticamente',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: 'poppins',
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
