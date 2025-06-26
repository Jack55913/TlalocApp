import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tlaloc/src/models/app_state.dart'; 
import 'package:url_launcher/url_launcher.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/resources/onboarding/onbording.dart';
import 'package:tlaloc/src/ui/screens/settings/credits.dart';
import 'package:tlaloc/src/ui/screens/settings/faq.dart';

class ConfigureScreen extends StatefulWidget {
  const ConfigureScreen({super.key});

  @override
  State<ConfigureScreen> createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset('assets/images/portrate.jpg', fit: BoxFit.fitWidth),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.surfaceContainerHighest,
                      width: 4,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 56,
                    backgroundImage:
                        user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                    child:
                        user?.photoURL == null
                            ? Icon(
                              Icons.account_circle,
                              size: 60,
                              color: theme.colorScheme.onSurface,
                            )
                            : null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70),

            // Información del usuario
            Text(
              user?.displayName ?? 'Usuario Tlaloc',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
                fontFamily: 'FredokaOne',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'correo@tlaloc.app',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 16,
              ),
            ),

            // Estadísticas clave
            Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<Map<String, dynamic>>(
                future: appState.getUserStats(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final stats = snapshot.data!;
                  final local = stats['local'];
                  final global = stats['global'];
                  final parajes = stats['distinctParajes'];
                  final total = stats['totalParajes'];

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard(context, 'Mediciones', '$local'),
                      _buildStatCard(context, 'Contribuciones', '$global'),
                      _buildStatCard(context, 'Parajes', '$parajes/$total'),
                    ],
                  );
                },
              ),
            ),

            // Sección de sugerencias
            // _buildProfileSection(
            //   context,
            //   title: 'Completa tu perfil',
            //   children: [
            //     _buildSuggestionItem(
            //       context,
            //       Icons.location_on,
            //       'Agrega tu ubicación',
            //     ),
            //     _buildSuggestionItem(
            //       context,
            //       Icons.description,
            //       'Añade una bio',
            //     ),
            //     _buildSuggestionItem(
            //       context,
            //       Icons.link,
            //       'Vincula redes sociales',
            //     ),
            //   ],
            // ),

            // Configuración
            _buildProfileSection(
              context,
              title: 'Configuración',
              children: [
                // _buildConfigItem(
                //   context,
                //   icon: Icons.notifications,
                //   title: 'Notificaciones',
                //   action: () {},
                // ),
                _buildConfigItem(
                  context,
                  icon: Icons.share,
                  title: 'Compartir aplicación',
                  action: () {
                    Share.share(
                      '¡Próximamente podrás obtener varios datos de él!\n\nDescárgala en tlaloc.org',
                      subject:
                          '¿Sabías que hay una app donde puedes registrar los datos de la lluvia en el Monte Tláloc?',
                    );
                  },
                ),
                _buildConfigItem(
                  context,
                  icon: Icons.feedback,
                  title: 'Enviar retroalimentación',
                  action: () {
                    launchUrl(
                      Uri.parse(
                        'mailto:tlloc-app@googlegroups.com?subject=Retroalimentación sobre Tláloc App',
                      ),
                    );
                  },
                ),
                _buildConfigItem(
                  context,
                  icon: Icons.description,
                  title: 'Términos y condiciones',
                  action: () => Navigator.pushNamed(context, '/privacy'),
                ),
                _buildConfigItem(
                  context,
                  icon: Icons.security,
                  title: 'Política de privacidad',
                  action: () => Navigator.pushNamed(context, '/politics'),
                ),
                _buildConfigItem(
                  context,
                  icon: Icons.info,
                  title: 'Acerca de',
                  action:
                      () => showAboutDialog(
                        context: context,
                        applicationIcon: CircleAvatar(
                          backgroundImage: const AssetImage(
                            'assets/images/img-1.png',
                          ),
                          backgroundColor: theme.colorScheme.surface,
                        ),
                        applicationLegalese: 'Con amor desde COLPOS ❤️',
                        applicationVersion: 'versión inicial (beta)',
                        children: [
                          _buildDialogItem(
                            context,
                            icon: Icons.people,
                            title: 'Ver créditos',
                            action:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CreditsPage(),
                                  ),
                                ),
                          ),
                          _buildDialogItem(
                            context,
                            icon: Icons.question_mark_rounded,
                            title: 'Preguntas Frecuentes',
                            action:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FaqPage(),
                                  ),
                                ),
                          ),
                          _buildDialogItem(
                            context,
                            icon: Ionicons.logo_facebook,
                            color: Colors.blue,
                            title: 'Síguenos en Facebook',
                            action:
                                () => launchUrl(
                                  Uri.parse(
                                    'https://www.facebook.com/Ciencia-Ciudadana-para-el-Monitoreo-de-Lluvia-100358326014423',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                ),
                          ),
                          _buildDialogItem(
                            context,
                            icon: Ionicons.logo_youtube,
                            color: Colors.red,
                            title: 'Síguenos en YouTube',
                            action:
                                () => launchUrl(
                                  Uri.parse(
                                    'https://www.youtube.com/channel/UC2wNEwvGEvnQVAX1Uv3qztA',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                ),
                          ),
                          _buildDialogItem(
                            context,
                            icon: Icons.email,
                            title: 'Mándanos un correo',
                            action:
                                () => launchUrl(
                                  Uri.parse(
                                    'mailto:tlloc-app@googlegroups.com',
                                  ),
                                ),
                          ),
                          _buildDialogItem(
                            context,
                            icon: Ionicons.logo_github,
                            title: 'Colabora en GitHub',
                            action:
                                () => launchUrl(
                                  Uri.parse(
                                    'https://github.com/Jack55913/TlalocApp',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                ),
                          ),
                        ],
                      ),
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: theme.colorScheme.error),
                  title: Text(
                    'Cerrar sesión',
                    style: TextStyle(color: theme.colorScheme.onSurface),
                  ),
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(
                      context,
                      listen: false,
                    );
                    provider.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Onboarding()),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildProfileSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  // Widget _buildSuggestionItem(
  //   BuildContext context,
  //   IconData icon,
  //   String text,
  // ) {
  //   final theme = Theme.of(context);
  //   return ListTile(
  //     leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
  //     title: Text(text, style: TextStyle(color: theme.colorScheme.onSurface)),
  //     trailing: Icon(Icons.add, color: theme.colorScheme.primary),
  //     onTap: () {},
  //   );
  // }

  Widget _buildConfigItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Function action,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: TextStyle(color: theme.colorScheme.onSurface)),
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      onTap: () => action(),
    );
  }

  Widget _buildDialogItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Function action,
    Color? color,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: color ?? theme.colorScheme.onSurface),
      title: Text(title, style: TextStyle(color: theme.colorScheme.onSurface)),
      onTap: () => action(),
    );
  }
}
