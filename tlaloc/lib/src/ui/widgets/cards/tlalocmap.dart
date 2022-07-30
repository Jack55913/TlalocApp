import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';

class TlalocMapData extends StatelessWidget {
  const TlalocMapData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage('assets/images/img-6.png'),
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tláloc',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Consumer<AppState>(
              builder: (context, state, child) => AutoSizeText(
                state.paraje,
                style: const TextStyle(
                  fontFamily: 'FredokaOne',
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Descripción', // Decía índice geográfico
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Consumer<AppState>(
              builder: (context, state, _) =>
                  FutureBuilder<Map<String, dynamic>>(
                future: state.getCurrentParajeData(),
                builder: (context, snapshot) {
                  late String text;
                  if (snapshot.hasError) {
                    text = snapshot.error.toString();
                  } else if (snapshot.hasData) {
                    /// Así puedes guardar cualquier otro dato sobre el paraje, solo
                    /// tienes que cambair 'descripcion' por el campo que tu quieras.
                    /// Lo editas en https://console.firebase.google.com/u/0/project/tlaloc-3c65c/firestore/data/
                    text = snapshot.data?['descripcion'] ??
                        'No hay descripción disponible...';
                  } else {
                    text = 'Cargando...';
                  }
                  return Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
  }
}
