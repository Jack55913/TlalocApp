// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/widgets/cards/map.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:latlng/latlng.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map/flutter_map.dart';

import 'app_state.dart';

class PhraseCard extends StatelessWidget {
  const PhraseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Go to InfoProyectPage
        Navigator.pushNamed(context, '/info');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: const [
                AppColors.blue1,
                AppColors.pruple1,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '💧💧 Precipitación:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'FredokaOne',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                    'Es la caída de agua procedente de las nubes en estado líquido (lluvia y llovizna),  sólido (granizo) y semisólido (nieve). Es una parte importante de ciclo hidrológico, ya que sin la precipitación no habría agua en los ecosistemas, ni en los lugares en donde vivimos.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 15,
                    )),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OMM (2008)',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'FredokaOne',
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Ver más',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TlalocMap()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dark2,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
              builder: (context, state, _) =>
                  FutureBuilder<Map<String, dynamic>>(
                future: state.getCurrentRolData(),
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
      ),
    );
  }
}
