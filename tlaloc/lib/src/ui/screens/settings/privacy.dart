// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';

const String _markdownData = """

# General

En tlaloc, nos preocupamos por sus datos personales, por lo que
hemos preparado esta Política de privacidad para explicar cómo les
recopilamos, usamos y compartimos ES IMPORTANTE MENCIONAR que los 
DATOS de NINGÚNA manera pueden ser utilizados sin el concentimiento 
de los coordinadores del proyecto.

Esta Política de privacidad (\"Política de privacidad\") detalla los
datos personales que PROYECTO tlaloc (\"tlaloc\",
\"tlaloc\", \"nosotros\" o \"nuestro\") recibe sobre usted, cómo lo
procesamos y sus derechos y obligaciones en relación con sus datos
personales PROYECTO tlaloc, UN PROYECTO DE ORIGEN
INDEPENDIENTE, OPERADA EN MEXICO, SIN UBICACIÓN FISICA ESPECIFICA, es el
controlador de datos a los efectos del Reglamento General de Protección
de Datos (\"GDPR\") y cualquier legislación local relevante (\" Leyes de
protección de datos\").

Al usar o acceder al Servicio, usted acepta los términos de esta
Política de privacidad. Los términos en mayúscula no definidos aquí
tienen los significados establecidos en los términos y condiciones (los
\"Términos y condiciones\"), ubicados en
<https://proyecto-tlaloc.web.app/terminos>. Podemos actualizar nuestra
Política de privacidad para reflejar los cambios en nuestras prácticas
de información. Si hacemos esto y los cambios son materiales,
publicaremos un aviso de que hemos realizado cambios en esta Política de
privacidad en el sitio web durante al menos 7 días antes de que se
realicen los cambios, e indicaremos la fecha de la última revisión de
estos términos en La parte inferior de la Política de privacidad.
Cualquier revisión de esta Política de privacidad entrará en vigor al
final de ese período de 7 días.

Si usted es un colaborador, trabajador o asesor de tlaloc, la
información sobre cómo manejamos su información personal está disponible
en la base de conocimiento interno de tlaloc. Con respecto a
los colaboradores "externos", con sede en Europa, estamos comprometidos
a cooperar con las autoridades de protección de datos (DPA) de la UE y
cumplir con el asesoramiento brindado por dichas autoridades con
respecto a los datos de recursos humanos transferidos desde la UE en el
contexto de la relación laboral.

## Información que recopilamos

Esta Política de privacidad explica cómo recopilamos, usamos y
compartimos sus datos personales.

## Información que usted proporciona

A través del proceso de registro, nos proporcionará su nombre, dirección
de correo electrónico (o la dirección de correo electrónico de los
padres) y edad o fecha de nacimiento. También nos proporcionará la
información de su transacción de pago si elige pagar por los servicios
de tlaloc.

## Datos de actividad

Cuando use el Servicio, enviará información y contenido a su perfil.
También generaremos datos sobre su uso de nuestros Servicios, incluida
su participación en actividades educativas en el Servicio, o su envío de
mensajes y de otra manera transmitiendo información a otros usuarios
(\"Datos de actividad\"). También recopilamos datos técnicos sobre cómo
interactúa con nuestros Servicios; Para obtener más información,
consulte Cookies.

tlaloc no comparte ninguno de sus datos personales con su
tutor. Usted es completamente anónimo para ellos de manera
predeterminada, y puede elegir libremente si les muestra su video o les
dice cualquier detalle personal como su nombre durante la conversación.
tlaloc solo comparte cierta información básica sobre el nivel
de habilidad con el tutor, antes de su lección, para que entiendan la
mejor manera de hablar con usted y su nombre de usuario.

## Datos de colaboración

Si se registra para ser colaborador, también nos proporcionará su
género, idioma nativo, lugar nativo y habilidades que domina para saber
si es competente o no. Cada vez que realice una prueba para colaborador,
también debe proporcionar una foto de una licencia de conducir válida,
pasaporte u otra identificación emitida por el gobierno y una foto de su
cara para verificar su identidad (\"Identificación de colaboración\").

## Datos de terceros

También recopilamos información sobre usted de terceros. Para obtener
más información, consulte Información obtenida por terceros.

## Investigación y desarrollo de productos

Podemos contactarlo para participar en actividades de investigación de
productos. Estos pueden incluir encuestas, entrevistas y otros tipos de
sesiones de retroalimentación. Cuando participe en estas actividades de
investigación, la información que proporcione se utilizará para probar,
mejorar y desarrollar nuestros productos. Grabaremos las transcripciones
de video, audio y texto de estos comentarios junto con cualquier
información de contacto adicional que proporcione y conservaremos estos
datos durante dos años.

Por favor contáctenos en <tlloc-app@googlegroups.com> para:

* Ej. Colaborar en las pruebas emitidas por el equipo interno de
tlaloc, investigación de nuevos métodos de aprendizaje, pruebas
de versiones beta, comentarios sobre el sentir de usted hacia el
proyecto...

* Solicite más información sobre las actividades de investigación para las
que se ha ofrecido.

* Optar por no ser contactado para actividades de investigación.
""";

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Términos y condiciones del servicio'),
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
