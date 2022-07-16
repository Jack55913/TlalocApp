// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/screens/home/kernel.dart';

void _goHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (BuildContext context) {
    return const HomePage();
  }), (Route<dynamic> route) => false);
}

class CommonSelectWidget extends StatelessWidget {
  final String paraje;
  final String ejido;
  final String commonimage;

  const CommonSelectWidget(
      {Key? key,
      required this.paraje,
      required this.ejido,
      required this.commonimage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          _goHome(context);
          final state = Provider.of<AppState>(context, listen: false);
          state.changeParaje(paraje);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    commonimage,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  paraje,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'FredokaOne',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Ejido de $ejido',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'poppins',
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
