import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

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
