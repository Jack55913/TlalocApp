// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
// import 'package:tlaloc/src/models/kernel.dart';

// String path = 'sounds/correcto.mp3'; //+
// int _counter = 0; //+

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  // final player = AudioPlayer(); //+

  const ButtonWidget({Key? key, required this.onClicked}) : super(key: key);

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
              'Usted está mandando el registro a la base de datos, puede eliminarlo posteriormente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              child: const Text('Enviar'),
              onPressed: onClicked,
              // onPressed: () => {
              //       onClicked,
              //       _counter++,
              //       player.play(AssetSource(path)),
              //       Navigator.pop(context),
              //       // Ir hacia atrás y no regresar a la pantalla anterior
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute<void>(
              //               builder: (BuildContext context) {
              //         return const HomePage();
              //       }), (Route<dynamic> route) => false)
              //     }
            ),
          ],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('    Enviar Medición    ',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'FredokaOne',
              fontSize: 24,
            )),
      ),
    );
  }
}
