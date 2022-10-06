// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';

const String _markdownData = """
# La audiencia se compone de varios grupos:

1. Ejidatarios de la montaña (Unión de Ejidos de la Montaña) y sus cuadrillas de trabajo: mayoritariamente hombres de entre 20 y 70 años, con nivel de estudios muy variado que llega hasta licenciatura, pero principalmente personas con educación básica a educación media. Son personas que suben a la montaña a hacer actividades de aprovechamiento forestal (aprovechan la madera y algunas otras cosas como musgo, perlilla y heno), y de mantenimiento del bosque (reforestación, chaponeo, podas, control de plagas, control de incendios, tendido de cercas, construcción de obras para control de erosión, remoción de suelo, mantenimiento de caminos, etc.). Algunos pertenecen a las localidades dueñas de los terrenos forestales, y otros son contratados de otros sitios, principalmente de Río Frío. En general suelen tener mucho trabajo, pero están dispuestos a colaborar y son los participantes del monitoreo con los que se ha tenido un contacto más estrecho. A este grupo se le va a dar una capacitación personalizada sobre el procedimiento para tomar las lecturas de los pluviómetros y se van a tener compromisos para la periodicidad de las mediciones, por lo que no es necesario convencerlos de participar.
2. Visitantes externos: son todas las personas que suben a la montaña pero que no provienen de los Ejidos de la Montaña. Principalmente adultos, con gusto por convivir en ambientes naturales y con las capacidades tecnológicas necesarias para participar (teléfono móvil, acceso a internet y facilidad para el manejo de aplicaciones). En este grupo se incluyen a personas que suben de manera frecuente y son una audiencia objetivo con mucho potencial de participación, como ciclistas, senderistas, campistas y guías de turistas de empresas privadas. Otros visitantes que suben cotidianamente, pero probablemente no estén interesados en participar, son grupos de personas con alto nivel socioeconómico que se dedican a subir en motocross, jeeps y racers, cuyo objetivo es la diversión sin considerar el bienestar de la naturaleza y el impacto que generan en la zona. Finalmente, también hay visitantes externos que suben muy esporádicamente o por ocasión única, algunos suben al evento de la montaña fantasma, otros vienen del interior de la república o simplemente no tienen la costumbre de subir continuamente. Estos tres subgrupos integran una audiencia que requiere más explicación sobre los objetivos del proyecto y de cómo pueden participar y beneficiarse.
3. Visitantes internos: son personas que forman parte de las localidades de los Ejidos de la Montaña pero que no trabajan con los ejidatarios, suben a realizar actividades como colecta de hongos o caminar. Es un grupo muy heterogéneo que incluye desde niños hasta adultos mayores, con mucho conocimiento sobre la zona de estudio (caminos y rutas, parajes, uso de los recursos naturales del bosque), pero probablemente no cuentan con las capacidades tecnológicas necesarias para participar (teléfono móvil, acceso a internet y facilidad para el manejo de aplicaciones).  Este grupo integra una audiencia que también requiere mucha explicación sobre los objetivos del proyecto y de cómo pueden participar y beneficiarse.
4. Miembros de instituciones gubernamentales y técnicos forestales: son profesionales encargados de supervisar las actividades de aprovechamiento y manejo forestal, de los recursos del agua y el estado del bosque. Incluye a empleados de Probosque (dependencia estatal), que supervisan constantemente los trabajos realizados en la zona y apoyan en las labores de combate de incendios. También incluye a empleados de otras entidades a nivel federal como (Comisión Nacional Forestal, Comisión Nacional de Áreas Naturales Protegidas, Secretaría de Recursos Naturales, Procuraduría Federal de Protección al Ambiente y Comisión Nacional del Agua). Es un grupo integrado por adultos de entre 30 y 50 años principalmente, con mucho conocimiento sobre la zona de estudio (caminos y rutas, parajes, uso de los recursos naturales del bosque), con las capacidades tecnológicas necesarias para participar (teléfono móvil, acceso a internet y facilidad para el manejo de aplicaciones).  Aunque algunos de ellos suben continuamente.
5. Miembros de la academia: son estudiantes, profesores e investigadores que realizan actividades de investigación de muy distinta índole en la zona. Algunos suben de manera esporádica y otros suben frecuentemente. Es un grupo integrado por adultos de entre 25 y 60 años principalmente, con mucho conocimiento sobre la zona de estudio (caminos y rutas, parajes, conocimiento sobre el bosque), con las capacidades tecnológicas necesarias para participar (teléfono móvil, acceso a internet y facilidad para el manejo de aplicaciones). Algunas de las instituciones con mayor presencia en la zona son el Colegio de Postgraduados, Universidad Autónoma Chapingo, UNAM, UAM. Aunque algunos de ellos suben continuamente.
""";

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Comunidad Tláloc App'),
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
