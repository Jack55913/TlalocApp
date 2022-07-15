// ignore_for_file: prefer_const_constructors

// import 'dart:math';
// import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';

String path = 'sounds/correcto.mp3';
int _counter = 0;
// late ConfettiController _controllerTopCenter;

class ButtonWidget extends StatefulWidget {
  final VoidCallback onClicked;
  const ButtonWidget({Key? key, required this.onClicked}) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  // @override
  // void initState() {
  //   super.initState();
  //   _controllerTopCenter =
  //       ConfettiController(duration: const Duration(seconds: 5));
  // }
  // @override
  // void dispose() {
  //   _controllerTopCenter.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: AppColors.green1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('¿Seguro(a) que desea enviar?'),
          content: const Text(
              'Usted está mandando el registro a la base de datos, puede eliminarla posteriormente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                'Cancelar',
              ),
              child: const Text('Cancelar'),
            ),
            TextButton(
              child: const Text('Enviar'),
              onPressed: () {
                widget.onClicked();
                final player = AudioPlayer();
                player.play(AssetSource(path));
                _counter++;
                // _controllerTopCenter.play();
              },
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('    Enviar Medición    ',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontSize: 28,
            )),
      ),
    );
  }
}

class PersonalMeausreData extends StatelessWidget {
  const PersonalMeausreData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'poppins',
        fontSize: 16,
      ),
    );

    // Stack(children: [
    //   ConfettiWidget(
    //     shouldLoop: false,
    //     blastDirection: pi / 2,
    //     confettiController: _controllerTopCenter,
    //     numberOfParticles: 10,
    //     child: Text(
    //       '$_counter',
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontFamily: 'poppins',
    //         fontSize: 16,
    //       ),
    //     ),
    //   ),
    // ]);
  }
}
