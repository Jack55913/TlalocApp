import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      tooltip: 'Mostrar información',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Registra datos de lluvia'),
          content: const Text(
              'Colabora con Tláloc App, en la obtención de datos para analizar los patrones de lluvia en el monte Tláloc. La campaña de monitoreo es permanente, tus registros son muy importantes ¡muchas gracias por tu aportación!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Siguiente'),
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}
