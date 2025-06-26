// ignore_for_file: depend_on_referenced_packages

import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/screens/settings/credits.dart';
import 'package:tlaloc/src/ui/screens/settings/faq.dart';
import 'package:tlaloc/src/ui/screens/settings/politics.dart';
import 'package:tlaloc/src/ui/screens/settings/privacy.dart';

/// A simple example of a dialog
class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Bounceable(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                title: Text(
                  'Compartir',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  // style: drawerTextColor,
                ),
                iconColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  Share.share('olimpiadama.web.app',
                      subject:
                          '¡Hay que competir juntos en la Olimpiada Mexicana de Agronomía! mira, te paso el link para inscribirse:');
                },
              ),
            ),
            Bounceable(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                title: Text(
                  'Enviar\nun correo',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  // style: drawerTextColor,
                ),
                iconColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'mailto:delegadosoma@googlegroups.com?subject=Retroalimentación sobre la Olimpiada Mexicana de Agronomía'),
                  );
                },
              ),
            ),
            Bounceable(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.description_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Términos y Condiciones',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  // style: drawerTextColor,
                ),
                iconColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  DialogNavigator.of(context).push(
                    FluidDialogPage(
                      // This dialog is shown in the center of the screen.
                      alignment: Alignment.center,
                      // Using a custom decoration for this dialog.
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                      ),
                      builder: (context) => const PoliticPage(),
                    ),
                  );
                },
              ),
            ),
            Bounceable(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Políticas de Privacidad',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  // style: drawerTextColor,
                ),
                iconColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  DialogNavigator.of(context).push(
                    FluidDialogPage(
                      // This dialog is shown in the center of the screen.
                      alignment: Alignment.center,
                      // Using a custom decoration for this dialog.
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                      ),
                      builder: (context) => const PrivacyPage(),
                    ),
                  );
                },
              ),
            ),
            Bounceable(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                title: Text(
                  'Acerca de',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                iconColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  // analytics.logEvent(name: 'open-about');
                  showAboutDialog(
                    applicationName: appName,
                    context: context,
                    applicationIcon: const CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          AssetImage('assets/images/tlaloc_logo.png'),
                    ),
                    applicationLegalese: 'Con amor desde la UACh ❤️',
                    applicationVersion: 'versión inicial',
                    children: [
                      Bounceable(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                          title: const Text('Ver créditos'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreditsPage()),
                            );
                          },
                        ),
                      ),
                      Bounceable(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.question_mark_rounded,
                            color: Colors.white,
                          ),
                          title: const Text('Preguntas Frecuentes'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FaqPage()),
                            );
                          },
                        ),
                      ),
                      Bounceable(
                        onTap: () {},
                        child: ListTile(
                          leading: const Icon(
                            Ionicons.logo_facebook,
                            color: Colors.blue,
                          ),
                          title: const Text('Síguenos en Facebook'),
                          onTap: () {
                            // analytics.logEvent(name: 'view-facebook');
                            launchUrl(
                              Uri.parse(
                                  'https://www.facebook.com/olimpiadama/'),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              'Copyright © Tlaloc App 2025',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Todos los derechos reservados',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
