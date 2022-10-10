// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/resources/onboarding/onbording.dart';

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
              return SelectableText(
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
                if (FirebaseAuth.instance.currentUser != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!),
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        'Nombre: ' + FirebaseAuth.instance.currentUser!.displayName!,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        'Correo: ' + FirebaseAuth.instance.currentUser!.email!,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                Consumer<GoogleSignInProvider>(
                  builder: (context, signIn, child) {
                    final name = FirebaseAuth.instance.currentUser?.displayName;
                    return ListTile(
                      leading: const Icon(Icons.login, color: Colors.green),
                      title: const SelectableText('Iniciar sesión'),
                      subtitle: SelectableText(name == null
                          ? 'No has iniciado sesión'
                          : 'Iniciaste sesión como $name'),
                      onTap: () async {
                        try {
                          await signIn.googleLogin();
                          // Ir a AddScreen:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const SelectableText(
                                  'Error al iniciar sesión'),
                              content: SelectableText('$e'),
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
                    title: const SelectableText('Cerrar sesión'),
                    onTap: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
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
