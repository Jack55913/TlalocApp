// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/page/logged_in_widget.dart';
import 'package:tlaloc/screens/navigation_bar.dart';
import 'package:tlaloc/screens/sign_in.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if(snapshot.hasData) {
              return BottomNavBar();
              // return LoggedInWidget();
            }
            else if (snapshot.hasError) {
              return Center(child: Text('¡Ocurrió un error!'));
            } else {
              return SignUpWidget();
            }
          },
        ),
      );
}
