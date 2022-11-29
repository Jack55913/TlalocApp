// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';

const String _markdownData = """
# ¿Quiénes pueden colaborar?

Ejidatarios, trabajadores, senderistas, ciclistas, campistas, recolectores de hongos, 

1.	Ejidatarios de la Unión de Ejidos de la Montaña. Son colaboradores muy activos en el proyecto. Generan registros a través de sus cuadrillas de trabajo que realizan actividades de aprovechamiento sustentable y manejo del bosque.
2.	Visitantes externos. Personas que suben a la montaña que no provienen de los Ejidos de la Montaña. En este grupo se incluyen a ciclistas, senderistas, campistas, entre otros.
3.	Visitantes internos. Personas que viven en localidades de la Unión de Ejidos de la Montaña que suben a realizar actividades como colecta de hongos o caminar. 
4.	Miembros de instituciones gubernamentales y técnicos forestales. Profesionales encargados de supervisar las actividades de aprovechamiento y manejo forestal, de los recursos del agua y el estado del bosque. Incluye a empleados de Instituciones gubernamentales.
5.	Miembros de la academia. Estudiantes y académicos que realizan actividades de investigación de muy distinta índole en la zona. 

""";

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const SelectableText('Comunidad Tláloc App'),
      ),
      body: const SafeArea(
        child: Markdown(
          selectable: true,
          data: _markdownData,
        ),
        // Ver cómo poner un botón de face aquí...
      ),
    );
  }
}
