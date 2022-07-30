// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/resources/page/date.dart';
import 'package:tlaloc/src/ui/widgets/measures/save_button.dart';
import 'package:tlaloc/src/ui/widgets/measures/images.dart';

String path = 'sounds/correcto.mp3';
int _counter = 0;

class AddScreen extends StatefulWidget {
  final Measurement? measurement;
  const AddScreen({Key? key, this.measurement}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File? newImage;
  DateTime dateTime = DateTime.now();
  num? precipitation;

  final player = AudioPlayer(); //+

  @override
  Widget build(BuildContext context) =>
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Consumer<GoogleSignInProvider>(
              builder: (context, signIn, child) {
                String place = Provider.of<AppState>(context).paraje;
                return AutoSizeText(
                  place,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'FredokaOne',
                  ),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Datetime(
                  updateDateTime: (value) {
                    dateTime = value;
                  },
                  updatePrecipitation: (value) {
                    precipitation = value;
                  },
                  measurement: widget.measurement,
                ),
                const Divider(
                  thickness: 1,
                ),
                // TODO: QUE YA FUNCIONE SIN QUE JALE INTERNET
                ImageUploaderWidget(),
                const Divider(
                  height: 20,
                  thickness: 1,
                ),
                ButtonWidget(
                  onClicked: () async {
                    try {
                      final state =
                          Provider.of<AppState>(context, listen: false);
                      if (widget.measurement == null) {
                        // Crear medición
                        state.addMeasurement(
                          precipitation: precipitation!,
                          time: dateTime,
                          image: newImage,
                        );
                        // TODO: QUE SE Muestra el banner
                        showBanner;
                        // Aumenta el contador
                        _counter++;
                        // Reproduce el sonido de enviado
                        player.play(AssetSource(path));
                        // Ir hacia atrás
                        Navigator.pop(context);
                        // Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                          return const HomePage();
                        }), (Route<dynamic> route) => false);
                      } else {
                        // Edita una medición ya existente
                        state.updateMeasurement(
                          id: widget.measurement!.id,
                          precipitation: precipitation!,
                          time: dateTime,
                          image: newImage,
                          oldImage: widget.measurement!.imageUrl,
                        );
                        player.play(AssetSource(path));
                        showBanner2;
                        Navigator.pop(context);
                        Navigator.pop(context);

                        // Works around the previous page being a stateful widget
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                          return const HomePage();
                        }), (Route<dynamic> route) => false);
                      }
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                              '¡No ingresaste la medición correctamente, inténtalo nuevamente!'),
                          content: Text('$e'),
                        ),
                      );
                    }
                  },
                ),
                const Divider(
                  thickness: 1,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
  void showBanner() => ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          backgroundColor: AppColors.green1,
          leading: Icon(Icons.check),
          content: Text(
            '¡Has agregado una medición!',
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );

  void showBanner2() => ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          leading: Icon(Icons.check),
          content: Text(
            '¡Listo, se ha modificado su medición!',
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 16,
            ),
          ),
          backgroundColor: AppColors.green1,
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
}

class PersonalMeausreData extends StatelessWidget {
  const PersonalMeausreData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'poppins',
        fontSize: 16,
      ),
    );
  }
}
