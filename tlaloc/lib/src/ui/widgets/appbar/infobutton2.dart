import 'package:flutter/material.dart';

class InfoButton2 extends StatelessWidget {
  const InfoButton2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      tooltip: 'Mostrar información',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Uso de datos de Lluvia'),
          content: const Text(
              'Los datos son de acceso público, sin embargo, para ser usados con fines científicos o comerciales es necesario solicitar autorización por parte de la coordinación del proyecto, así como otorgar los créditos correspondientes. Las bases de datos completas y la autorización de uso pueden ser solicitados al correo teresa.gonzalez@colpos.mx. Teléfono de contacto: 5630908507\n\n Los datos registrados son acumulados y cuando se observan valores de 0, indican un reinicio en el pluviómetro \n\n Cómo citar la información: Base de datos de precipitación del Monte Tláloc. (año de consulta), Proyecto de Ciencia Ciudadana para el monitoreo de lluvia en el Monte Tláloc. Postgrado en Ciencias Forestales, Colegio de Postgraduados, Estado de México, México.'),
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
