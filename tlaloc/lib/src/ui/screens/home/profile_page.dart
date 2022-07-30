// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/resources/onboarding/onbording.dart';

class ConfigureScreen extends StatefulWidget {
  const ConfigureScreen({Key? key}) : super(key: key);

  @override
  State<ConfigureScreen> createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Nombre: ' + user.displayName!,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Correo: ' + user.email!,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
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
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Onboarding()),
            );
          },
                  ),
              ]),
        ));
  }
}
