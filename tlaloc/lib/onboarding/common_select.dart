import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/widgets/cards/common_card.dart';
import 'package:tlaloc/widgets/cards/qr.dart';

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
                  const Center(
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
                  const SizedBox(height: 16),
                  const Text(
                    'Selecciona el Pluviómetro automáticamente',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      const QrSelectWidget(),
                      const Text(
                        'Selecciona el Pluviómetro manualmente',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'poppins',
                            color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      /// Para agregar o quitar parajes: constants.dart
                      for (var i = 0; i < parajes.length; i++)
                        CommonSelectWidget(
                            paraje: parajecolection[i],
                            ejido: ejidocolection[i],
                            commonimage: commonimages[i]),
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
