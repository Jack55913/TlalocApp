// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:tlaloc/onboarding/common_select.dart';

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
                  ),
                ),
                Spacer(),
                Image(
                  alignment: Alignment.center,
                  width: 300,
                  image: AssetImage('assets/images/img-1.png'),
                ),
                Spacer(),
                Center(
                  child: Text(
                    'Bienvenido a Tláloc App :)',
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
                    await provider.googleLogin();
                    if (provider.recentlySignedInUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommonSelectPage(),
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
                  icon: FaIcon(FontAwesomeIcons.person, color: Colors.black),
                  label: Text('Modo Incógnito'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CommonSelectPage()),
                    );
                  },
                ),
                SizedBox(height: 40),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Al registratrse a Tláloc App, aceptas nuestros términos y condiciones y políticas de privacidad',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'poppins'),
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
