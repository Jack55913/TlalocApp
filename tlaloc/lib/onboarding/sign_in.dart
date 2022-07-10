// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:tlaloc/onboarding/common_select.dart';
import 'package:tlaloc/onboarding/role.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.green1,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Inicia sesión o crea una cuenta',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FredokaOne',
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Image(
                  alignment: Alignment.center,
                  width: 300,
                  image: AssetImage('assets/images/img-1-4.png'),
                ),
                Spacer(),
                Center(
                  child: Text(
                    'Bienvenido a Tláloc App',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FredokaOne',
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Por favor ingresa tu cuenta para continuar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'poppins'),
                  ),
                ),
                Spacer(),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 48),
                  ),
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: Text('Iniciar sesión con Google'),
                  onPressed: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);

                    try {
                      await provider.googleLogin();
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error al iniciar sesión'),
                          content: Text('$e'),
                        ),
                      );
                    }
                    if (provider.recentlySignedInUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoleSelection(),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 48),
                  ),
                  icon: Icon(Icons.person, color: Colors.black),
                  label: Text('Modo Incógnito'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoleSelection(),
                        // CommonSelectPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 40),
                SizedBox(height: 8),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        const TextSpan(
                          text: 'Al iniciar sesión aceptas ',
                        ),
                        TextSpan(
                          text:
                              'nuestros términos y condiciones y política de privacidad',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(
                                  Uri.parse(
                                      // TODO: Add privacy policy url
                                      'https://tlaloc.web.app/web/privacidad/'),
                                  mode: LaunchMode.inAppWebView,
                                ),
                        ),
                        const TextSpan(
                            text:
                                ', y aceptas recibir correos electrónicos con actualizaciones sobre el proyecto.'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
