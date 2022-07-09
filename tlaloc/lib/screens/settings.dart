// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:tlaloc/onboarding/logged_in_widget.dart';
import 'package:tlaloc/onboarding/common_select.dart';
import 'package:tlaloc/page/conditional_onboarding_page.dart';
import 'package:tlaloc/screens/politics.dart';
import 'package:tlaloc/screens/privacy.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
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
          title: Consumer<GoogleSignInProvider>(
            builder: (context, signIn, child) {
              String name =
                  signIn.user?.displayName?.split(' ')[0] ?? 'Incógnito';
              return Text(
                'Perfil de $name',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'FredokaOne',
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.place),
                  title: Text('Elige un Paraje'),
                  subtitle: Text(Provider.of<AppState>(context).paraje),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommonSelectPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Compartir aplicación'),
                  onTap: () {
                    Share.share(
                        '¡Próximamente podrás obtener varios datos de él!\n\nDescárgala en tlaloc.org',
                        subject:
                            '¿Sabías que hay una app donde puedes registrar los datos de la lluvia en el Monte Tláloc? ');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('Enviar retroalimentación'),
                  onTap: () {
                    launchUrl(
                      Uri.parse(
                          'mailto:tlloc-app@googlegroups.com?subject=Retroalimentación sobre Tláloc App'),
                    );
                  },
                ),
                ListTile(
                    leading: Icon(Icons.description),
                    title: Text('Términos y condiciones'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PoliticPage()),
                      );
                    }),
                ListTile(
                    leading: Icon(Icons.privacy_tip),
                    title: Text('Política de privacidad'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPage()),
                      );
                    }),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Acerca de'),
                  onTap: () {
                    // analytics.logEvent(name: 'open-about');
                    showAboutDialog(
                      context: context,
                      applicationIcon: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/img-1.png'),
                        backgroundColor: Colors.white,
                      ),
                      applicationLegalese:
                          'Con amor desde COLPOS ❤️\nCréditos y programación: Emilio Álvarez Herrera',
                      applicationVersion: 'versión inicial (beta)',
                      children: [
                        ListTile(
                          leading: Icon(Icons.people),
                          title: Text('Ver créditos'),
                          onTap: () {
                            // analytics.logEvent(name: 'view-credits');
                            launchUrl(
                              Uri.parse(
                                  'https://tlaloc-3c65c.web.app/acerca_de'),
                              mode: LaunchMode.inAppWebView,
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Ionicons.logo_facebook),
                          title: Text('Síguenos en Facebook'),
                          onTap: () {
                            // analytics.logEvent(name: 'view-facebook');
                            launchUrl(
                              Uri.parse(
                                  'https://www.facebook.com/Ciencia-Ciudadana-para-el-Monitoreo-de-Lluvia-100358326014423'),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Ionicons.logo_twitter),
                          title: Text('Síguenos en Twitter'),
                          onTap: () {
                            // analytics.logEvent(name: 'view-twitter');
                            launchUrl(
                              Uri.parse('https://twitter.com/colpos'),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('Mándanos un correo'),
                          onTap: () {
                            // analytics.logEvent(
                            // name: 'contact', parameters: {'source': 'about'});
                            launchUrl(
                                Uri.parse('mailto:tlloc-app@googlegroups.com'));
                          },
                        ),
                        ListTile(
                          leading: Icon(Ionicons.logo_github),
                          title: Text('Colabora en GitHub'),
                          onTap: () {
                            // analytics.logEvent(name: 'view-github');
                            launchUrl(
                              Uri.parse(
                                  'https://github.com/Jack55913/TlalocApp'),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                Consumer<GoogleSignInProvider>(
                  builder: (context, signIn, child) {
                    final name = FirebaseAuth.instance.currentUser?.displayName;
                    return ListTile(
                      leading: Icon(Icons.login),
                      title: Text('Iniciar sesión'),
                      subtitle: Text(name == null
                          ? 'No has iniciado sesión'
                          : 'Iniciaste sesión como $name'),
                      onTap: () async {
                        try {
                          await signIn.googleLogin();
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error al iniciar sesión'),
                              content: Text('$e'),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                if (FirebaseAuth.instance.currentUser != null)
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Cerrar sesión'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoggedInWidget()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bug_report),
                    title: Text('Abrir pantalla inicial'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConditionalOnboardingPage()),
                      );
                    },
                  ),
              ]),
        ));
  }
}
