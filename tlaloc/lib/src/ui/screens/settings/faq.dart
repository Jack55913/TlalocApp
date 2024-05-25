// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';
// import '../shared/markdown_demo_widget.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = """
## ¿Qué información puedo ver?

En Tláloc App, puedes ver cuánto ha llovido en diferentes puntos del monte Tláloc, así como una gráfica de barras y las colaboraciones de todos los usuarios

## ¿Puedo borrar mis datos o modificarlos?  

¡Claro que sí! Sólo debes deslizar hacia la derecha (para editar o compartir) o izquierda (para eliminar) la medición, en la pantalla de bitácora

## ¿Cómo ver los datos de otro paraje?

Al estar en un paraje, puedes observar todos los datos de él, sin embargo para observar el de otros debes cambiar de paraje desde el menú, la página principal para cambiar paraje o en la pantalla para subir mediciones

## ¿Puedo modificar los datos de alguien más?

¡NO! Sólo puedes modificar tus datos para no alterar la base de datos
""";

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Preguntas Frecuentes ✒️'),
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
