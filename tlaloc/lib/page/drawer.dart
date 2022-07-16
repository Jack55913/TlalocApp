import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:tlaloc/onboarding/logged_in_widget.dart';
import 'package:tlaloc/onboarding/common_select.dart';
import 'package:tlaloc/onboarding/onbording.dart';
import 'package:tlaloc/onboarding/role.dart';
import 'package:tlaloc/screens/credits.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          leading: const Icon(Icons.place, color: Colors.red),
          title: const Text('Elige un Paraje'),
          subtitle: Text(Provider.of<AppState>(context).paraje),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CommonSelectPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.work, color: Colors.brown),
          title: const Text('Elige un Rol'),
          subtitle: Text(Provider.of<AppState>(context).rol),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RoleSelection()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text('Compartir aplicación'),
          onTap: () {
            Share.share(
                '¡Próximamente podrás obtener varios datos de él!\n\nDescárgala en tlaloc.org',
                subject:
                    '¿Sabías que hay una app donde puedes registrar los datos de la lluvia en el Monte Tláloc? ');
          },
        ),
        ListTile(
          leading: const Icon(Icons.feedback, color: Colors.green),
          title: const Text('Enviar retroalimentación'),
          onTap: () {
            launchUrl(
              Uri.parse(
                  'mailto:tlloc-app@googlegroups.com?subject=Retroalimentación sobre Tláloc App'),
            );
          },
        ),
        ListTile(
            leading: const Icon(Icons.description, color: Colors.blue),
            title: const Text('Términos y condiciones'),
            onTap: () {
              Navigator.pushNamed(context, '/privacy');
            }),
        ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.blue),
            title: const Text('Política de privacidad'),
            onTap: () {
              Navigator.pushNamed(context, '/politics');
            }),
        ListTile(
          leading: const Icon(Icons.info, color: Colors.blue),
          title: const Text('Acerca de'),
          onTap: () {
            // analytics.logEvent(name: 'open-about');
            showAboutDialog(
              context: context,
              applicationIcon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/img-1.png'),
                backgroundColor: Colors.white,
              ),
              applicationLegalese:
                  'Con amor desde COLPOS ❤️\nCréditos y programación: Emilio Álvarez Herrera',
              applicationVersion: 'versión inicial (beta)',
              children: [
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Ver créditos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreditsPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Ionicons.logo_facebook),
                  title: const Text('Síguenos en Facebook'),
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
                  leading: const Icon(Ionicons.logo_twitter),
                  title: const Text('Síguenos en Twitter'),
                  onTap: () {
                    // analytics.logEvent(name: 'view-twitter');
                    launchUrl(
                      Uri.parse('https://twitter.com/colpos'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Mándanos un correo'),
                  onTap: () {
                    // analytics.logEvent(
                    // name: 'contact', parameters: {'source': 'about'});
                    launchUrl(Uri.parse('mailto:tlloc-app@googlegroups.com'));
                  },
                ),
                ListTile(
                  leading: const Icon(Ionicons.logo_github),
                  title: const Text('Colabora en GitHub'),
                  onTap: () {
                    // analytics.logEvent(name: 'view-github');
                    launchUrl(
                      Uri.parse('https://github.com/Jack55913/TlalocApp'),
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
              leading: const Icon(Icons.login, color: Colors.green),
              title: const Text('Iniciar sesión'),
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
                      title: const Text('Error al iniciar sesión'),
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
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar sesión'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoggedInWidget()),
              );
            },
          ),
        ListTile(
          leading: const Icon(Icons.bug_report, color: Colors.yellow),
          title: const Text('Abrir pantalla inicial'),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return Onboarding();
            }), (Route<dynamic> route) => false);
          },
        ),
      ]),
    );
  }
}
