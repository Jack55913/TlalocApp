import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/cards/common_card.dart';
import 'package:tlaloc/src/ui/widgets/cards/qr.dart';

class CommonSelectPage extends StatelessWidget {
  const CommonSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    '¿Qué pluviómetro estás observando?',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'FredokaOne',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  QrSelectWidget(),
                  SizedBox(height: 20),
                  Text(
                    'Seleccionar manualmente',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'FredokaOne',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  CommonSelectWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
