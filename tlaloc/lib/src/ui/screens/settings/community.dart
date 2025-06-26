// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';

const String _markdownData = """
# Todos podemos colaborar 

Ejidatarios, trabajadores, senderistas, ciclistas, campistas, recolectores de hongos, cientificos, estudiantes, etc.

1.	Ejidatarios de la Unión de Ejidos de la Montaña. Son colaboradores muy activos en el proyecto. Generan registros a través de sus cuadrillas de trabajo que realizan actividades de aprovechamiento sustentable y manejo del bosque.
""";

const String segundo = """
2.	Visitantes externos. Personas que suben a la montaña que no provienen de los Ejidos de la Montaña. En este grupo se incluyen a ciclistas, senderistas, campistas, entre otros.
""";

const String tercero = """
3.	Visitantes internos. Personas que viven en localidades de la Unión de Ejidos de la Montaña que suben a realizar actividades como colecta de hongos o caminar. 
""";

const String cuatro = """
4.	Miembros de instituciones gubernamentales y técnicos forestales. Profesionales encargados de supervisar las actividades de aprovechamiento y manejo forestal, de los recursos del agua y el estado del bosque. Incluye a empleados de Instituciones gubernamentales.
""";
const String cinco = """
5.	Miembros de la academia. Estudiantes y académicos que realizan actividades de investigación de muy distinta índole en la zona. 
""";

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Comunidad Tláloc App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // ignore: prefer_const_constructors
      body: SingleChildScrollView(
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(_markdownData, style: TextStyle(color: Colors.black)),
                Image(
                  image: AssetImage('assets/images/unoeji.jpg'),
                  fit: BoxFit.fill,
                  // width: 200,
                  height: 250,
                ),
                Text(
                  segundo,
                  style: TextStyle(color: Colors.black),
                  // selectable: true,
                ),
                Image(
                  image: AssetImage('assets/images/dosvist.jpg'),

                  fit: BoxFit.fill,
                  // width: 200,
                  height: 250,
                ),
                Text(
                  // selectable: true,
                  tercero,
                  style: TextStyle(color: Colors.black),
                ),
                Image(
                  image: AssetImage('assets/images/trespob.jpg'),
                  fit: BoxFit.fill,
                  // width: 200,
                  height: 250,
                ),
                Text(
                  // selectable: true,
                  cuatro,
                  style: TextStyle(color: Colors.black),
                ),
                // Image(
                //   image: AssetImage('assets/images/cuatroinst.jpg'),
                //   fit: BoxFit.fill,
                //   // width: 200,
                //   height: 250,
                // ),
                Text(
                  // selectable: true,
                  cinco,
                  style: TextStyle(color: Colors.black),
                ),
                // TODO: VER POR QUÉ NO LA QUIERE CARGAR
                // Image(
                //   image: AssetImage('assets/images/cincoacad.jpg'),
                //   fit: BoxFit.fill,
                //   // width: 200,
                //   height: 250,
                // ),
              ],
            ),
          ),
          // Ver cómo poner un botón de face aquí...
        ),
      ),
    );
  }
}
