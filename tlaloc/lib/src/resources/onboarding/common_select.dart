import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/cards/common_card.dart';
import 'package:tlaloc/src/ui/widgets/cards/qr.dart';

class CommonSelectPage extends StatelessWidget {
  const CommonSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.purple2,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '¿Qué pluviómetro estás observando?',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'FredokaOne',
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Selecciona el Pluviómetro automáticamente',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      QrSelectWidget(),
                      Text(
                        'Selecciona el pluviómetro manualmente',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'poppins',
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      CommonSelectWidget(),
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
