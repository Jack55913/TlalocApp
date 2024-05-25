import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/ui/widgets/cards/map.dart';
import 'package:url_launcher/url_launcher.dart';

class TlalocMapData extends StatelessWidget {
  const TlalocMapData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Image(
          // image: AssetImage("assets/images/mapa2.png"),
          image: AssetImage("assets/images/mapa3.jpg"),
          fit: BoxFit.cover,
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
          'Descripción:', // Decía índice geográfico
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'poppins',
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Consumer<AppState>(
          builder: (context, state, _) => FutureBuilder<Map<String, dynamic>>(
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
                  fontSize: 14,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<AppState>(
              builder: (context, state, _) =>
                  FutureBuilder<Map<String, dynamic>>(
                      future: state.getCurrentParajeData(),
                      builder: (context, snapshot) {
                        late String url;
                        if (snapshot.hasError) {
                          url = snapshot.error.toString();
                        } else if (snapshot.hasData) {
                          url = snapshot.data?['url'] ??
                              'https://www.youtube.com/watch?v=GJuTIxwQw0k&list=RDGJuTIxwQw0k&start_radio=1';
                        } else {
                          url =
                              'https://www.youtube.com/watch?v=GJuTIxwQw0k&list=RDGJuTIxwQw0k&start_radio=1';
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              launchUrl(
                                Uri.parse(url),
                              );
                            },
                            icon: const FaIcon(FontAwesomeIcons.mapPin,
                                color: Colors.red),
                            label: const Text(
                              'Google\nMaps',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        );
                      }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                        'https://es.wikiloc.com/rutas-mountain-bike/monitoreo-de-la-lluvia-ruta-2-141098082'),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.map, color: Colors.green),
                label: const Text(
                  'Mapa en\nWikiloc',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  // TOOD AGREGAR DESCARGAR MAPA
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TlalocMap()),
                  );
                },
                icon:
                    const FaIcon(FontAwesomeIcons.filePdf, color: Colors.black),
                label: const Text(
                  'Mapa\nen Pdf',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
