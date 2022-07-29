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
import 'package:tlaloc/src/resources/page/date.dart';
import 'package:tlaloc/src/ui/widgets/appbar/profilepage.dart';
import 'package:tlaloc/src/ui/widgets/buttons/save_button.dart';
import '../../widgets/appbar/infobutton.dart';

String path = 'sounds/correcto.mp3';
int _counter = 0;

class AddScreen extends StatefulWidget {
  final Measurement? measurement;
  AddScreen({Key? key, this.measurement}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
  final player = AudioPlayer(); //+

  @override
  Widget build(BuildContext context) =>
      Stack(alignment: Alignment.topCenter, children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                InfoButton(),
                ProfilePage(),
              ],
              title: Consumer<GoogleSignInProvider>(
                builder: (context, signIn, child) {
                  String place = Provider.of<AppState>(context).paraje;
                  return AutoSizeText(
                    place,
                    style: TextStyle(
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
                              children: [
                                MaterialButton(
                                    child: Row(
                                      children: [
                                        Icon(Icons.image),
                                        Text(" Desde la Galería",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'poppins',
                                            )),
                                      ],
                                    ),
                                    onPressed: () {
                                      pickImage();
                                    }),
                                SizedBox(height: 20),
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
                                SizedBox(height: 20),
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
                  // TODO: QUE SE ENVÍE A LA BASE DE DATOS
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
                          player.play(AssetSource(path));
                          // Ir hacia atrás
                          Navigator.pop(context);
                          Navigator.pop(context);
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

                          // More and more:

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
