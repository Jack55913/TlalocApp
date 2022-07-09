// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/onboarding/common_select.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue3,
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/img-3.png',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Selecciona una opción',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'FredokaOne',
              color: AppColors.lightBlue,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 30),
          RoleSelectionWidget(),
          SizedBox(height: 10),
          RoleSelectionWidget(),
        ],
      ),
    );
  }
}

class RoleSelectionWidget extends StatelessWidget {
  const RoleSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
          child: ElevatedButton.icon(
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
            MaterialPageRoute(builder: (context) => const CommonSelectPage()),
          );
        },
      )),
    );
  }
}
