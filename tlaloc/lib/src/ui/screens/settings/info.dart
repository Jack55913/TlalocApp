// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';
// import '../shared/markdown_demo_widget.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = """
# Ciencia ciudadana para el monitoreo participativo de la lluvia en un gradiente altitudinal del Monte Tláloc, Texcoco, Estado de México
___

## Propósito del proyecto
Lograr un trabajo colaborativo con distintos grupos de la sociedad, bajo un esquema de ciencia ciudadana, para conocer la variación de la precipitación en un gradiente altitudinal del Monte Tláloc, Texcoco, Estado de México.

## Importancia del proyecto
La lluvia es muy importante para el funcionamiento del ciclo hidrológico a nivel local. Influye en cómo funcionan los ecosistemas y los seres vivos que en ellos habitan. Asimismo, determina en gran medida la disponibilidad de agua que puede usarse en las actividades humanas.
En las montañas, incluido el monte Tláloc, suele llover  más que en los valles circundantes. Esto se debe a que las corrientes de aire cargadas de humedad chocan contra las montañas, lo cual las fuerza a elevarse y a enfriarse, generando precipitaciones. Sin embargo, casi no se mide cuánto llueve en las montañas debido a que suelen ser sitios poco accesibles, lejanos o inseguros para dejar instrumentos de medición. 
El monitoreo de la lluvia es muy importante para entender cómo funcionan los bosques de montaña y generar estrategias para conservarlos, y para mantener todos aquellos procesos que nos generan beneficios como la provisión de agua, la regulación del clima y el mantenimiento de la biodiversidad.

## Nuestra estrategia
En este estudio se plantea una estrategia de Ciencia Ciudadana para superar la dificultad del monitoreo de la lluvia en zonas de montaña. La Ciencia Ciudadana es una forma de investigación colaborativa que involucra a todas las personas interesadas en participar, con la finalidad de aprender sobre un tema y solucionar problemas juntos. De esta manera no solo se logra el objetivo de obtener datos relevantes en términos científicos, sino que además se propician la difusión del conocimiento y la vinculación entre distintos miembros de la sociedad que se encuentran en un territorio.

## ¿Qué hacemos?
El monitoreo de la lluvia consiste en el registro de los niveles del agua almacenada en pluviómetros de medición manual, colocados en parajes ubicados a distintas altitudes en el monte Tláloc. Para realizar los registros de la lluvia se cuenta con la participación activa de la mayoría de los ejidos pertenecientes a la Unión de Ejidos de la Montaña, quienes son dueños de las tierras donde se ubica el proyecto. También se cuenta con la participación de personas entusiastas que han decidido colaborar cuando vistan la zona para realizar actividades recreativas, científicas y de gestión gubernamental. Para mayor información sobre los procedimientos de registro y envío de observaciones consulta nuetros documentos en la sección ¿Cómo colaborar?

## Conceptos clave

* 	Ciencia ciudadana
Es una forma de investigación colaborativa que involucra a todas las personas interesadas en participar, con la finalidad de aprender sobre un tema y solucionar problemas juntos.
* 	Precipitación
Es la caída de agua procedente de las nubes en estado líquido (lluvia y llovizna),  sólido (granizo) y semisólido (nieve). Es una parte importante de ciclo hidrológico, ya que sin la precipitación no habría agua en los ecosistemas, ni en los lugares en donde vivimos.
* 	Monitoreo
Consiste en la observación de un suceso o fenómeno para recolectar información bajo un método previamente establecido. En el caso del monitoreo de la lluvia, se refiere al registro de los niveles de agua almacenados en los pluviómetros.
* 	Pluviómetro
Es un dispositivo diseñado para almacenar el agua procedente de la lluvia que cae en una superficie y tiempo determinado.
* 	Evaporímetro
Es un dispositivo diseñado para estimar el agua que se ha escapado de los pluviómetros por evaporación. Lo encontrarás a un lado de cada pluviómetro.


""";

class InfoProyectPage extends StatelessWidget {
  const InfoProyectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const SelectableText('Acerca del proyecto'),
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
