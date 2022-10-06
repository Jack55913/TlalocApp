import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      tooltip: 'Mostrar información',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const SelectableText('Registra datos de lluvia'),
          content: const SelectableText(
              'Colabora con Tláloc App, en la obtención de datos para analizar los patrones de lluvia en el monte Tláloc. Tendremos tres campañas de monitoreo en los siguientes periodos: del 15 de Julio al 15 de Septiembre, del 21 de Octubre al 10 de Diciembre y del 4 de marzo al 29 de Abril'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Siguiente'),
              child: const SelectableText('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}
