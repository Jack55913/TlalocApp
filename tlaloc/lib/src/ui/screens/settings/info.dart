// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton2.dart';
// import '../shared/markdown_demo_widget.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = """
# Ciencia ciudadana para el monitoreo participativo de la lluvia en un gradiente altitudinal del Monte Tláloc, Texcoco, Estado de México
___

## ¿Qué es Tláloc app?
Es una aplicación para el envío y consulta de datos de lluvia que se generan con la colaboración de las personas que suben al Monte Tláloc. Forma parte de un proyecto de ciencia ciudadana para el monitoreo participativo de lluvia.

## ¿Quiénes somos?
Somos académicos del Postgrado en Ciencias Forestales del Colegio de Postgraduados campus Montecillo y estudiantes de distintas instituciones (Colpos, Uach, etc.). Se cuenta con el apoyo de la Unión de Ejidos de la Montaña (Texcoco). Coordinadora de proyecto: Dra. Teresa M. González Martínez.

## ¿Para qué sirve el monitoreo de lluvia?
Permite saber dónde, cuándo y cuánto llueve en el Monte Tláloc, para entender cómo funciona el bosque y para definir acciones para cuidarlo. Los datos pueden ser usados por productores forestales, ciudadanos, académicos, estudiantes, dependencias de gobierno, etc.
Revisa las reglas para el uso de datos de lluvia en información (i)


""";

class InfoProyectPage extends StatelessWidget {
  const InfoProyectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Acerca del proyecto'),
        actions: const <Widget>[
          InfoButton2(),
        ],
      ),
      body: const SafeArea(
        child: Markdown(
          selectable: true,
          data: _markdownData,
        ),
      ),
    );
  }
}
