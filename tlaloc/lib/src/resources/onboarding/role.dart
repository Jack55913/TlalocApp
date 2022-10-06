// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blue3,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/img-3.png',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const SelectableText(
                    'Selecciona una opción',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FredokaOne',
                      color: AppColors.lightBlue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AutoSizeText(
                    'Si recibiste una capacitación por parte del equipo, entonces elige MONITOR:',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  /// Para agregar o quitar parajes: constants.dart
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var rol in roles.entries)
                            RolSelectWidget(
                              rol: rol.key,
                              icon: rol.value,
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ));
  }
}

void _goHome(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CommonSelectPage()),
  );
}

class RolSelectWidget extends StatelessWidget {
  final String rol;
  final Widget icon;

  const RolSelectWidget({
    Key? key,
    required this.rol,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          _goHome(context);
          final state = Provider.of<AppState>(context, listen: false);
          state.changeRol(rol);
        },
        child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [icon, SelectableText(rol)])),
      ),
    );
  }
}
