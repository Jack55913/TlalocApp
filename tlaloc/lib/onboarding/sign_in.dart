// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Inicia sesión o crea una cuenta',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'FredokaOne',
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Image(
                image: AssetImage('assets/images/img-1-4.png'),
              ),
              Spacer(),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Bienvenido a $appName',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FredokaOne',
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Por favor ingresa tu cuenta para continuar',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'poppins'),
                    ),
                  ],
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
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
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
                    Navigator.pushNamed(context, '/role');
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
                  Navigator.pushNamed(context, '/common');
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
                                Uri.parse('https://tlaloc.web.app/privacy/'),
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
    );
  }
}
