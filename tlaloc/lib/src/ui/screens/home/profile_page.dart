// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/resources/onboarding/onbording.dart';
import 'package:tlaloc/src/ui/widgets/appbar/drawer.dart';

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
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         DrawerApp();
          //       },
          //       icon: Icon(Icons.menu))
          // ],
          backgroundColor: AppColors.dark2,
          title: Consumer<GoogleSignInProvider>(
            builder: (context, signIn, child) {
              String name = signIn.user!.displayName!.split(' ')[0];
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
                      Text(
                        'Nombre: ${FirebaseAuth.instance.currentUser!.displayName!}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Correo: ${FirebaseAuth.instance.currentUser!.email!}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                Consumer<GoogleSignInProvider>(
                  builder: (context, signIn, child) {
                    final name = FirebaseAuth.instance.currentUser?.displayName;
                    return Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.login, color: Colors.green),
                          title: const Text('Iniciar sesión'),
                          subtitle: Text(name == null
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
                                  title: const Text('Error al iniciar sesión'),
                                  content: Text('$e'),
                                ),
                              );
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.home, color: Colors.white),
                          title: const Text('Ir a la página inicial'),
                          subtitle: Text('Pantalla de bienvenida'),
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                              return Onboarding();
                            }), (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    );
                  },
                ),
                if (FirebaseAuth.instance.currentUser != null)
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Cerrar sesión'),
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
