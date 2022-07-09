// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:latlng/latlng.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map/flutter_map.dart';

import 'app_state.dart';

class PhraseCard extends StatelessWidget {
  const PhraseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //Poner fondo con gradiente
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: const [
              AppColors.blue1,
              AppColors.pruple1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: const [
              Text(
                  'La captación de agua de lluvia, es la solución caida del cielo. Ésto implica que debemos cuidar los bosques, porque son ellos los reguladores hidrológicos más importantes',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontSize: 15,
                  )),
              SizedBox(height: 20),
              Text('Emilio Álvarez Herrera',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'FredokaOne',
                    fontSize: 18,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class MeditionDataShow extends StatelessWidget {
  const MeditionDataShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          Text('Medición de datos',
              style: TextStyle(
                // color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 15,
              )),
          Text('Revisa los errores comúnes al momento de medir',
              style: TextStyle(
                // color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          launchUrl(Uri.parse('mailto:tlloc-app@googlegroups.com'));
        },
        child: const Text(
          '¡Contáctanos!',
        ),
      ),
    );
  }
}

class DynamicTlalocMap extends StatelessWidget {
  const DynamicTlalocMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dark2,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            //     child: FlutterMap(
            //   options: MapOptions(
            //     // center: LatLng(19.4, -99.1),
            //     zoom: 16.0,
            //     minZoom: 10,
            //   ),
            //   layers: [
            //     TileLayerOptions(
            //       urlTemplate:
            //           'https://api.mapbox.com/styles/v1/{user}/{style}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
            //       additionalOptions: {
            //         'accessToken': 'pk.eyJ1IjoibWl5b3RsIiwiYSI6ImNsMWNiZWZhazA2MzAzZW1wMnJ1Zjd3MGUifQ.c57DM17bhxFfxTYoLcu1_Q',
            //       },
            //     ),
            //   ],
            // ),
            child: Image(
              image: AssetImage('assets/images/img-6.png'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Tláloc',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20),
          Consumer<AppState>(
            builder: (context, state, child) => AutoSizeText(
              state.paraje,
              style: TextStyle(
                // color: Colors.white,
                fontFamily: 'FredokaOne',
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Descripción', // Decía índice geográfico
            style: TextStyle(
              // color: Colors.white,
              fontFamily: 'poppins',
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
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
                  style: TextStyle(
                    // color: Colors.white,
                    fontFamily: 'poppins',
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
