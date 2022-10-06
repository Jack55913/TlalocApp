/// De https://github.com/miyotl/miyotl/blob/master/lib/widgets/empty_state.dart

import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class EmptyState extends StatelessWidget {
  final String text;
  final String? image;

  // ignore: use_key_in_widget_constructors
  const EmptyState(this.text, [this.image]);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Image.asset(
              image!,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'FredokaOne',
                    fontSize: 24,
                  ),
                ),
                Image.asset(
                  'assets/images/ajolote-triste.png',
                  // width: MediaQuery.of(context).size.width * 0.8,
                ),
                const Text(
                  '¡Inicia sesión para poder crear, editar o eliminar mediciones a la base de datos de Tláloc App!.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.green1,
                    fontFamily: 'FredokaOne',
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
