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
import 'package:tlaloc/onboarding/onbording.dart';
import 'package:tlaloc/onboarding/role.dart';
import 'package:tlaloc/screens/credits.dart';
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
                      MaterialPageRoute(builder: (context) => Onboarding()),
                    );
                  },
                ),
              ]),
        ));
  }
}
