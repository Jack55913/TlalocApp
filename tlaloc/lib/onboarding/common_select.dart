// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
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

                      /// Para agregar o quitar ejidos: constants.dart
                      for (var ejido in ejidos.entries)
                        CommonSelectWidget(
                          ejido: ejido.key,
                          hectareas: ejido.value,
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
  final String ejido;
  final num hectareas;

  const CommonSelectWidget(
      {Key? key, required this.ejido, required this.hectareas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          _goHome(context);
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
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: AutoSizeText(
                      ejido.split(' ').map((e) => e[0]).join(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'FredokaOne',
                        fontSize: 100,
                      ),
                    ),
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
            String? ejido;
            if (qrResult.contains('tlaloc.web.app')) {
              ejido = qrResult
                  .split('/')
                  .last
                  .replaceAll('_', ' ')
                  .replaceAll('%20', ' ');
            }
            if (ejido == null || ejido == '') {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('El código QR no es válido'),
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
              state.changeEjido(ejido);
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('No escaneaste ningún código QR'),
                content:
                    Text('Intenta de nuevo o selecciona tu ejido manualmente'),
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
