// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';
// import '../shared/markdown_demo_widget.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = """
# Ciencia ciudadana para el monitoreo participativo de la lluvia en un gradiente altitudinal del Monte Tláloc, Texcoco, Estado de México

## Introducción

En la mayoría de las montañas México la lluvia es la principal vía de entrada de agua en las cuencas, por lo tanto, de su ocurrencia depende el funcionamiento del ciclo hidrológico a nivel local. La lluvia es de gran importancia para que ocurran los ciclos biogeoquímicos en los ecosistemas terrestres y para mantener distintos procesos biológicos de los seres vivos. Define en gran medida la distribución geográfica de los ecosistemas forestales y acuáticos, e influye en la disponibilidad de agua que se usa para las actividades humanas (Maderey & Jiménez, 2005; Abbott et al., 2019). Todo esto es muy importante para los ecosistemas naturales y para las comunidades humanas.

En las montañas, incluido el monte Tláloc, suele llover  más que en los valles circundantes. Esto se debe a que las nubes chocan contra las montañas, lo cual las fuerza a elevarse y a enfriarse, generando precipitaciones. Sin embargo, casi no se mide cuánto llueve en las montañas debido a que suelen ser sitios poco accesibles, lejanos o inseguros para dejar instrumentos de medición.

En este estudio se plantea una estrategia de Ciencia Ciudadana para superar la dificultad del monitoreo de la lluvia en zonas de montaña. La Ciencia Ciudadana es una forma de investigación colaborativa que involucra a todas las personas interesadas en participar, con la finalidad de aprender sobre un tema y solucionar problemas juntos. De esta manera no solo se logra el objetivo de obtener datos relevantes en términos científicos, sino que además se propician la educación ambiental, la socialización del conocimiento y la vinculación entre los distintos miembros de la sociedad.

El monitoreo de la lluvia consistirá en registro de los niveles del agua almacenada en pluviómetros de medición manual, colocados en parajes ubicados a distintas altitudes en el monte Tláloc. Para realizar los registros de la lluvia se va a contar con la participación activa de la mayoría de los ejidos pertenecientes a la Unión de Ejidos de la Montaña, quienes son dueños de las tierras donde se ubica el proyecto. También se espera contar con la participación varios grupos de personas que vistan la zona para realizar actividades recreativas, científicas y de gestión gubernamental. La frecuencia de los registros será variable, ya que algunos sitios de monitoreo estarán ubicados en lugares más accesibles y frecuentados que otros. 

## Propósito

Lograr un trabajo colaborativo con distintos grupos de la sociedad para conocer la variación de la precipitación en un gradiente altitudinal del Monte Tláloc, Texcoco, Estado de México, bajo un esquema de ciencia ciudadana.

## Conceptos clave

* **Ciencia ciudadana**: 

Es una forma de investigación colaborativa que involucra a todas las personas interesadas en participar, con la finalidad de aprender sobre un tema y solucionar problemas juntos.

* **Precipitación**

Es la caída de agua procedente de las nubes en estado líquido (lluvia y llovizna),  sólido (granizo) y semisólido (nieve). Es una parte importante de ciclo hidrológico, ya que sin la precipitación no habría agua en los ecosistemas, ni en los lugares en donde vivimos.

* **Monitoreo**

Consiste en la observación de un suceso o fenómeno para recolectar información bajo un método previamente establecido. En el caso del monitoreo de la precipitación, se refiere al registro de los niveles de agua almacenados en los pluviómetros.

* **Pluviómetro**

Es un dispositivo diseñado para almacenar el agua procedente de la precipitación que cae en una superficie y tiempo determinado.


""";

class InfoProyectPage extends StatelessWidget {
  const InfoProyectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Acerca del proyecto'),
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
