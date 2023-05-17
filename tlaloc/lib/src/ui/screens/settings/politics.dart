// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';
// import '../shared/markdown_demo_widget.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = """
## 1.  General

Los sitios web de Tláloc (\"Sitios web\") y las aplicaciones
móviles (\"Aplicaciones\") y los servicios relacionados (junto con los
Sitios web, el \"Servicio\") son operados por PROYECTO Ciencia Ciudadana para el Monitoreo de Lluvia y 
(\"Tláloc App\", \"TlálocApp\" o \"nosotros\"). El acceso y uso del
Servicio está sujeto a los siguientes Términos y Condiciones del
Servicio (\"Términos y Condiciones\"). Al acceder o utilizar cualquier
parte del Servicio, usted declara que ha leído, entendido y acepta estar
sujeto a estos Términos y Condiciones, incluidas las modificaciones
futuras. Tláloc puede modificar, actualizar o cambiar estos
Términos y Condiciones. Si lo hacemos, publicaremos un aviso de que
hemos realizado cambios en estos Términos y Condiciones en los Sitios
web durante al menos 7 días después de que se publiquen los cambios e
indicaremos en la parte inferior de los Términos y Condiciones la fecha
en que estos términos se revisaron por última vez. Cualquier revisión de
estos Términos y Condiciones entrará en vigor antes de (i) el final de
dicho período de 7 días o (ii) la primera vez que acceda o utilice el
Servicio después de dichos cambios. Si no acepta cumplir con estos
Términos y Condiciones, no está autorizado a usar, acceder o participar
en el Servicio.

Tenga en cuenta que estas condiciones contienen un arbitraje obligatorio
de la disposición de disputas que requiere el uso de arbitraje en una
base individual para resolver disputas en ciertas circunstancias, pero
no juicios de jurado o demandas colectivas. vea estos términos aquí.

## 2.  Descripción del sitio web y el servicio

El Servicio permite a los usuarios acceder y utilizar una variedad de
servicios educativos, incluyendo el aprendizaje o la práctica de un
idioma, consulta de datos, y la creación y visualización de nuevo
contenido para la plataforma.

## 3.  Registro; Presentación de Contenido

a\. Registro

En relación con el registro y el uso del Servicio, usted acepta (i)
proporcionar información precisa, actual y completa sobre usted y/o su
organización según lo solicitado por Tláloc; (ii) para mantener
la confidencialidad de su contraseña y otra información relacionada con
la seguridad de su cuenta; (iii) mantener y actualizar de inmediato
cualquier información de registro que proporcione a Tláloc App,
para mantener dicha información precisa, actualizada y completa; y (iv)
ser totalmente responsable de todo el uso de su cuenta y de cualquier
acción que tenga lugar a través de su cuenta.

b\. Envíos de COLABORADORES

Si usted es o se convierte en colaborador, puede ofrecer traducir o
haber traducido ciertas acciones (cursos, literatura, servicios)
existentes a otros idiomas y puede ofrecer contribuir con nuevas
acciones al Servicio, según lo acordado entre usted y Tláloc
caso por caso. Sujeto a las pautas publicadas en el Servicio, usted
puede realizar dichas traducciones o crear dichas acciones de acuerdo
con su propio horario y utilizando sus propias instalaciones y recursos.
No está obligado a convertirse en Colaborador de acciones y puede cesar
sus actividades como Colaborador de las acciones en cualquier momento.
Usted reconoce que no desea y no recibirá compensación por sus
actividades como Colaborador de acciones o por el uso que hagamos de
cualquier Material de Colaborador de acciones (como se define a
continuación) que envíe. Cualquier traducción de una acción de
Tláloc existente que envíe o haya enviado y cualquier acción de
idioma nuevo que envíe o haya enviado como Colaborador de acciones
(colectivamente, \"Materiales del Colaborador de acciones\") es
propiedad de usted (sujeto, por supuesto, a que conservemos la propiedad
de acción Tláloc existente que tradujo). Al enviar cualquier
Material de Colaborador de acciones, usted nos otorga una licencia
totalmente pagada y mundial, no exclusiva, libre de regalías, perpetua y
sublicenciable para reproducir, mostrar, realizar, modificar, crear
trabajos derivados de, distribuir y utilizar dicho Material de
Colaborador de acciones de cualquier manera.

c\. Contenido general

Como condición para enviar cualquier calificación, reseña, información,
datos, texto, fotografías, clips de audio, obras audiovisuales,
traducciones, tarjetas u otros materiales en los Servicios
(\"Contenido\"), por la presente otorga a Tláloc una licencia
libre de regalías, perpetua, irrevocable, mundial, no exclusiva,
transferible y sublicenciable para usar, reproducir, copiar, adaptar,
modificar, fusionar, exhibir públicamente, crear obras derivadas de
sublicenciar a través de varios niveles del Contenido y reconoce que
esta licencia no puede ser terminada por usted una vez que su Contenido
se envía a los Servicios. Usted declara que es propietario o ha
garantizado todos los derechos legales necesarios para que el Contenido
enviado por usted sea utilizado por usted, Tláloc y otros, tal
como se describe y se contempla en estos Términos y Condiciones. Usted
entiende que otros usuarios tendrán acceso al Contenido y que ni ellos
ni Tláloc tienen ninguna obligación con usted ni con nadie de
mantener la confidencialidad del Contenido.

## 4.  Sus representaciones y garantías

Usted declara y garantiza a TlálocS que su acceso y uso del
Servicio se realizará de acuerdo con estos Términos y Condiciones y con
todas las leyes, reglas y regulaciones aplicables de los ESTADOS UNIDOS
MEXICANOS y cualquier otra jurisdicción relevante, incluidas las
relativas a la conducta en línea o al contenido aceptable, y las
relativas a la transmisión de datos o información exportada desde los
ESTADOS UNIDOS MEXICANOS y/o la jurisdicción en la que reside. Además,
declara y garantiza que ha creado o posee cualquier material que envíe a
través del Servicio (incluidos los Materiales de Traducción, los
Materiales del Colaborador de acciones, los Materiales de Actividad y el
Contenido) y que tiene el derecho, según corresponda, de concedernos una
licencia para usar ese material como se establece anteriormente o el
derecho de asignarnos ese material como se establece a continuación.

Usted declara y garantiza que (1) no está organizado bajo las leyes de,
que operan desde, o de otra manera, residen habitualmente en un país o
territorio que es el objetivo o sanciones económicas o comerciales
integrales de los ESTADOS UNIDOS MEXICANOS (es decir, un embargo) o (2)
identificadas en una lista de personas prohibidas o restringidas, como
la Lista de Nacionales y Personas Bloqueadas especialmente designados de
LA UIF Y LA COMISION DE PLD/FT Y ANTICORRUPCION DEL IMCP DE LOS ESTADOS
UNIDOS MEXICANOS o (3) de lo contrario el objetivo de las sanciones de
los ESTADOS UNIDOS MEXICANOS.

## 5.  Uso inapropiado

Usted no cargará, mostrará ni proporcionará en o a través del Servicio
ningún contenido que: (i) sea difamatorio, abusivo, amenazante,
acosador, odioso, ofensivo o violado de cualquier otra manera cualquier
ley o infrinja el derecho de cualquier tercero (incluyendo derechos de
autor, marca registrada, privacidad, publicidad u otros derechos
personales o de propiedad); o (ii) a juicio exclusivo de
Tláloc, es objetable o que restringe o inhibe a cualquier otra
persona de usar el Servicio o que pueda exponer a Tláloc o a
sus usuarios a cualquier daño o responsabilidad de cualquier tipo.


""";

class PoliticPage extends StatelessWidget {
  const PoliticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Políticas de Privacidad'),
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
