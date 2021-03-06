import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/screens/home/kernel.dart';

void _goHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (BuildContext context) {
    return const HomePage();
  }), (Route<dynamic> route) => false);
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
                  title: const Text('El código QR no es válido.'),
                  content: (paraje == null || paraje == '')
                      ? null
                      : Text(
                          'Tlaloc App no se encuentra disponible en el paraje "$paraje".'),
                  actions: [
                    TextButton(
                      child: const Text('De acuerdo'),
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
                title: const Text('No escaneaste ningún código QR'),
                content: const Text(
                    'Intenta de nuevo o selecciona tu paraje manualmente'),
                actions: [
                  TextButton(
                    child: const Text('De acuerdo'),
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
              children: const [
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
