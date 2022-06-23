// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/screens/home.dart';

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

                      /// TODO: poner el número de hectáreas.
                      /// Para agregar o quitar ejidos, basta con editar esto.
                      CommonSelectWidget(
                        ejido: 'San Dieguito Xuhimanca',
                        hectareas: 99999,
                      ),
                      CommonSelectWidget(
                        ejido: 'San Pablo Ixayoc',
                        hectareas: 99999,
                      ),
                      CommonSelectWidget(
                        ejido: 'San Juan Totolapan',
                        hectareas: 99999,
                      ),
                      CommonSelectWidget(
                        ejido: 'San Miguel Tlaixpan',
                        hectareas: 99999,
                      ),
                      CommonSelectWidget(
                        ejido: 'Nativitas',
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
      child: InkWell(
          onTap: () async {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return const HomePage();
            }), (Route<dynamic> route) => false);
            final state = Provider.of<AppState>(context, listen: false);
            state.changeEjido(ejido);
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
