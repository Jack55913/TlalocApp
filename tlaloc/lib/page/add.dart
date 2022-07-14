// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:tlaloc/page/date.dart';
import 'package:tlaloc/screens/home.dart';
import 'package:tlaloc/widgets/button_widget.dart';
import 'package:tlaloc/models/app_state.dart';


  // final player = AudioPlayer();

class AddScreen extends StatefulWidget {
  final Measurement? measurement;

  const AddScreen({Key? key, this.measurement}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}
  int _counter = 0-1;

class _AddScreenState extends State<AddScreen> {
  late ConfettiController _controllerTopCenter;
  File? newImage;
  DateTime dateTime = DateTime.now();
  num? precipitation;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final File imageTemp = File(image.path);

      setState(() => newImage = imageTemp);
    } on PlatformException catch (e) {
      print('Falló al obtener la imágen: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => newImage = imageTemp);
    } on PlatformException catch (e) {
      print('Falló al obtener la imágen: $e');
    }
  }

  @override
  void initState() {
    _counter++;
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Stack(alignment: Alignment.topCenter, children: [
        Scaffold(
          appBar: AppBar(
            title: Consumer<GoogleSignInProvider>(
              builder: (context, signIn, child) {
                String place = Provider.of<AppState>(context).paraje;
                return AutoSizeText(
                  place,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'FredokaOne',
                    // fontSize: 24,
                    // letterSpacing: 2,
                  ),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ConfettiWidget(
                  shouldLoop: false,
                  blastDirection: pi / 2,
                  confettiController: _controllerTopCenter,
                  numberOfParticles: 10,
                ),

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
                FutureBuilder<ConnectivityResult>(
                  future: Connectivity().checkConnectivity(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        (snapshot.hasData &&
                            snapshot.data == ConnectivityResult.none)) {
                      return Text(
                          'No está soportado subir imágenes sin internet (aún).');
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            'Sube la imagen del pluviómetro',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'FredokaOne',
                            ),
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                  child: Row(
                                    children: [
                                      Icon(Icons.image),
                                      Text(" Desde la Galería",
                                          style: TextStyle(
                                            // color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: 'poppins',
                                          )),
                                    ],
                                  ),
                                  onPressed: () {
                                    pickImage();
                                  }),
                              SizedBox(height: 15),
                              MaterialButton(
                                  child: Row(
                                    children: [
                                      Icon(Icons.camera_alt),
                                      Text(" Desde la cámara",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'poppins',
                                          )),
                                    ],
                                  ),
                                  onPressed: () {
                                    pickImageC();
                                  }),
                            ],
                          ),
                          if (newImage == null &&
                              widget.measurement != null &&
                              widget.measurement!.imageUrl != null)
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.measurement!.imageUrl!,
                              ),
                            )
                          else
                            newImage != null
                                ? Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.file(newImage!),
                                  )
                                : Text(
                                    "⚠️ No ha seleccionado ninguna imágen ⚠️"),
                        ],
                      );
                    }
                  },
                ),
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
                        initState;
                        state.addMeasurement(
                          precipitation: precipitation!,
                          time: dateTime,
                          image: newImage,
                        );
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                          return const AddScreen();
                        }), (Route<dynamic> route) => false);
                        _controllerTopCenter.play();
                        // player.setSource(AssetSource('sounds/correcto.mp3'));
                      } else {
                        // Edita una medición ya existente
                        state.updateMeasurement(
                          id: widget.measurement!.id,
                          precipitation: precipitation!,
                          time: dateTime,
                          image: newImage,
                          oldImage: widget.measurement!.imageUrl,
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);

                        /// Works around the previous page being a stateful widget
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Ocurrió un error al guardar'),
                          content: Text('$e'),
                        ),
                      );
                    }
                  },
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                ),
              ],
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
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'poppins',
        fontSize: 16,
      ),
    );
  }
}
