// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
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
                  Center(
                    child: Text(
                      '¿Qué pluviómetro estás observando?',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FredokaOne',
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Selecciona el Pluviómetro automáticamente',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      QrSelectWidget(),
                      Text(
                        'Selecciona el Pluviómetro manualmente',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'poppins',
                            color: Colors.white),
                      ),
                      SizedBox(height: 16),

                      /// Para agregar o quitar parajes: constants.dart
                      for (var paraje in parajes.entries)
                        CommonSelectWidget(
                          paraje: paraje.key,
                          ejido: paraje.value,
                          // TODO: CADA WIDGET CON SU IMAGEN
                          commonimage: commonimages[
                              parajes.values.toList().indexOf(paraje.value)],
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

void _goHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (BuildContext context) {
    return const HomePage();
  }), (Route<dynamic> route) => false);
}

class CommonSelectWidget extends StatelessWidget {
  final String paraje;
  final String ejido;
  final String commonimage;

  const CommonSelectWidget(
      {Key? key,
      required this.paraje,
      required this.ejido,
      required this.commonimage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          _goHome(context);
          final state = Provider.of<AppState>(context, listen: false);
          state.changeParaje(paraje);
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
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 50,
                  backgroundImage: AssetImage(
                    commonimage,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  paraje,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'FredokaOne',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Ejido de $ejido',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QrSelectWidget extends StatelessWidget {
  const QrSelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          final qrResult = await showDialog<String>(
            context: context,
            builder: (context) {
              final size = min(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height);
              return Dialog(
                child: SizedBox(
                  height: size,
                  width: size,
                  child: MobileScanner(
                    onDetect: (barcode, args) {
                      Navigator.pop(context, barcode.rawValue);
                    },
                  ),
                ),
              );
            },
          );
          if (qrResult != null) {
            String? paraje;
            if (qrResult.contains('tlaloc.web.app')) {
              paraje = qrResult
                  .split('/')
                  .last
                  .replaceAll('_', ' ')
                  .replaceAll('%20', ' ');
            }
            if (paraje == null ||
                paraje == '' ||
                !parajes.containsKey(paraje)) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('El código QR no es válido.'),
                  content: (paraje == null || paraje == '')
                      ? null
                      : Text(
                          'Tlaloc App no se encuentra disponible en el paraje "$paraje".'),
                  actions: [
                    TextButton(
                      child: Text('De acuerdo'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                barrierDismissible: true,
              );
            } else {
              _goHome(context);
              final state = Provider.of<AppState>(context, listen: false);
              state.changeParaje(paraje);
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('No escaneaste ningún código QR'),
                content:
                    Text('Intenta de nuevo o selecciona tu paraje manualmente'),
                actions: [
                  TextButton(
                    child: Text('De acuerdo'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              barrierDismissible: true,
            );
          }
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
        ),
      ),
    );
  }
}
