// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/date.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/ui/widgets/measures/save_button.dart';

class AddScreen extends StatefulWidget {
  final Measurement? measurement;
  const AddScreen({Key? key, this.measurement}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

int _counter = 0;

class _AddScreenState extends State<AddScreen> {
  File? newImage;
  DateTime dateTime = DateTime.now();
  num? precipitation;
  bool? pluviometer;
  String path = 'sounds/correcto.mp3';

  final player = AudioPlayer(); //+
  Future pickImage() async {
    try {
      //       uploadTask = mStorageRef.putFile(localFile),
      // sessionUri = uploadTask.getUploadSessionUri(),
      // uploadTask = mStorageRef.putFile(localFile,
      //             new StorageMetadata.Builder().build(), sessionUri);
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
  Widget build(BuildContext context) => SafeArea(
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
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
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
                          pluviometer: false,
                        );
                        // TODO: QUE SE Muestra el banner
                        // showBanner;
                        // Aumenta el contador
                        _counter++;
                        // Reproduce el sonido de enviado
                        player.play(AssetSource(path));
                        // Ir hacia atrás
                        // Navigator.pop(context);
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
                          pluviometer: false,
                        );
                        player.play(AssetSource(path));
                        // showBanner2;
                        Navigator.pop(context);
                        Navigator.pop(context);

                        // Works around the previous page being a stateful widget
                        // Navigator.pop(context);
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
              ),
            ],
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
                  updatePluviometer: (value) {
                    pluviometer = value;
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
                      return const Text(
                          // TODO: AQUÏ VA LA FUNCIÖN PARA QUE NO TENGA INTERNET
                          'No se puede subir imágenes sin internet (aún).\n Súbelo más tarde desde la galeria');
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            'Toma una foto y sube la imagen del\n pluviómetro cuando llegues a casa',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'FredokaOne',
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                  leading: CircleAvatar(
                                      backgroundColor: Colors.purple[300],
                                      child: Icon(Icons.image,
                                          color: Colors.purple[900])),
                                  title: const Text(
                                    " Desde la Galería",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                  onTap: () {
                                    pickImage();
                                  }),
                              const SizedBox(height: 15),
                              // TODO: hacer que sirva sin wifi!!! y luego activar esto
                              // ListTile(
                              //     leading: CircleAvatar(
                              //         backgroundColor: Colors.purple[300],
                              //         child: Icon(Icons.camera_alt,
                              //             color: Colors.purple[900])),
                              //     title: const Text("Desde la Cámara",
                              //         style: TextStyle(
                              //           color: Colors.grey,
                              //           fontSize: 16,
                              //           fontFamily: 'poppins',
                              //         )),
                              //     onTap: () {
                              //       pickImageC();
                              //     }),
                              const SizedBox(height: 20),
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
                                : const Text(
                                    "⚠️ No ha seleccionado ninguna imágen ⚠️",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                        ],
                      );
                    }
                  },
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                ),

                // const Divider(
                //   thickness: 1,
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      );
  // TODO: Hacer que sirva el banner luego de enviar medición
  // void showBanner() => ScaffoldMessenger.of(context).showMaterialBanner(
  //       MaterialBanner(
  //         backgroundColor: AppColors.green1,
  //         leading: Icon(Icons.check),
  //         content: Text(
  //           '¡Has agregado una medición!',
  //           style: TextStyle(
  //             fontFamily: 'poppins',
  //             fontSize: 16,
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  //             },
  //             child: Text(
  //               'OK',
  //               style: TextStyle(
  //                 fontFamily: 'poppins',
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  // void showBanner2() => ScaffoldMessenger.of(context).showMaterialBanner(
  //       MaterialBanner(
  //         leading: Icon(Icons.check),
  //         content: Text(
  //           '¡Listo, se ha modificado su medición!',
  //           style: TextStyle(
  //             fontFamily: 'poppins',
  //             fontSize: 16,
  //           ),
  //         ),
  //         backgroundColor: AppColors.green1,
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  //             },
  //             child: Text(
  //               'OK',
  //               style: TextStyle(
  //                 fontFamily: 'poppins',
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
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
