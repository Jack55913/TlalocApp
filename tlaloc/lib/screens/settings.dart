// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tlaloc/models/constants.dart';
// import 'package:share_plus/share_plus.dart';

import '../models/constants.dart';

class ConfigureScreen extends StatefulWidget {
  const ConfigureScreen({Key? key}) : super(key: key);

  @override
  State<ConfigureScreen> createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.dark2,
          title: const Text('Ejido de:',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FredokaOne',
                fontSize: 24,
                letterSpacing: 2,
              )),
        ),
        body: ListView(
          
          children: const <Widget>[
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Cambiar de Ejido'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartir aplicación'),
            // onTap: () {
            //   analytics.logShare(
            //       contentType: 'invite', itemId: 'app', method: 'drawer');
            //       Share.share('¡Próximamente podrás obtener varios datos de él!\n\nDescárgala en tlaloc.org', subject: '¿Sabías que hay una app donde puedes registrar los datos de la lluvia en el Monte Tláloc? ');
            //   // Share.share(
            //   //     ' ');
            // },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Enviar retroalimentación'),
            // onTap: () {
            //   analytics
            //       .logEvent(name: 'contact', parameters: {'source': 'drawer'});
            //   launch(
            //     'mailto:twotimessea@hotmail.com?subject=Retroalimentación sobre Tlaloc App',
            //   );
            // },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Acerca de'),
            // onTap: () {
            //   analytics.logEvent(name: 'open-about');
            //   showAboutDialog(
            //     context: context,
            //     applicationIcon: CircleAvatar(
            //       backgroundImage: AssetImage('assets/images/img-1.png'),
            //       backgroundColor: Colors.white,
            //     ),
            //     applicationLegalese: 'Con amor desde COLPOS ❤️',
            //     applicationVersion: 'versión inicial (beta)',
            //     children: [
            //       ListTile(
            //         leading: Icon(Icons.people),
            //         title: Text('Ver créditos'),
            //         onTap: () {
            //           analytics.logEvent(name: 'view-credits');
            //           launch(
            //             'https://proyecto-miyotl.web.app/acerca_de',
            //             forceWebView: true,
            //           );
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(Ionicons.logo_facebook),
            //         title: Text('Síguenos en Facebook'),
            //         onTap: () {
            //           analytics.logEvent(name: 'view-facebook');
            //           launch('https://www.facebook.com/colpos.cienciasagricolas');
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(Ionicons.logo_twitter),
            //         title: Text('Síguenos en Twitter'),
            //         onTap: () {
            //           analytics.logEvent(name: 'view-twitter');
            //           launch('https://twitter.com/colpos');
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(Icons.email),
            //         title: Text('Mándanos un correo'),
            //         onTap: () {
            //           analytics.logEvent(
            //               name: 'contact', parameters: {'source': 'about'});
            //           launch('mailto:twotimessea@hotmail.com');
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(Ionicons.logo_github),
            //         title: Text('Colabora en GitHub'),
            //         onTap: () {
            //           analytics.logEvent(name: 'view-github');
            //           launch('https://github.com/Jack55913/TlalocApp');
            //         },
            //       ),
            //     ],
            //   );
            // },
          ),
        ]));
  }
}
