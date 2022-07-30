// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/resources/page/date.dart';
import 'package:tlaloc/src/ui/widgets/buttons/save_button.dart';
import 'package:tlaloc/src/ui/widgets/objects/images.dart';

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
      Stack(alignment: Alignment.topCenter, children: [
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
            // drawer: DrawerApp(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /// NOTE: Datetime includes the mm too, even if the name is confusing
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
                          // Inicia el conffetti
                          // initState;
                          // Crear medición
                          state.addMeasurement(
                            precipitation: precipitation!,
                            time: dateTime,
                            image: newImage,
                          );
                          _counter++;
                          player.play(AssetSource(path));
                          // Ir hacia atrás
                          Navigator.pop(context);
                          Navigator.pop(context);
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
                          Navigator.pop(context);
                          Navigator.pop(context);

                          /// Works around the previous page being a stateful widget
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
                                '¡No ingresaste la medición del pluviómetro!'),
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
        ),
      ]);
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
