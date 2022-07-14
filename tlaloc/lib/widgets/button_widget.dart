// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  

  const ButtonWidget({Key? key, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.green1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('¿Seguro(a) que desea enviar?'),
                content: const Text(
                    'Usted está mandando el registro a la base de datos, puede eliminarla posteriormente.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancelar',),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    child: const Text('Enviar'),
                    onPressed: onClicked,
                    // onPressed: () => Navigator.pop(context, 'Enviar'),
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
        ));
  }
}




// int _counter = 0;
// class ButtonWidget extends StatefulWidget {
//   const ButtonWidget({Key? key}) : super(key: key);

//   @override
//   State<ButtonWidget> createState() => _ButtonWidgetState();
// }

// class _ButtonWidgetState extends State<ButtonWidget> {

// late String text;
// late VoidCallback onClicked;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//     ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             primary: AppColors.green1,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50))),
//         onPressed: () => showDialog<String>(
//               context: context,
//               builder: (BuildContext context) => AlertDialog(
//                 title: const Text('¿Seguro(a) que desea enviar?'),
//                 content: const Text(
//                     'Usted está mandando el registro a la base de datos, puede eliminarla posteriormente.'),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, 'Cancelar'),
//                     child: const Text('Cancelar'),
//                   ),
//                   TextButton(
//                     child: const Text('Enviar'),
//                     onPressed: () => {
//                     onClicked,
//                     _incrementCounter,
//                     }
//                   ),
//                 ],
//               ),
//             ),
//         child: Text('Guardar',
//             style:
//                 TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
//   }
// }