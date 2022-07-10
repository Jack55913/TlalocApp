// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:tlaloc/page/date.dart';
import 'package:tlaloc/widgets/button_widget.dart';
import 'package:tlaloc/models/app_state.dart';

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

// final _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonWidget(
              text: 'Guardar',
              onClicked: () async {
                try {
                  final state = Provider.of<AppState>(context, listen: false);
                  if (widget.measurement == null) {
                    // TODO: Crear contador en la hoja de personal_measures.dart para que sepa el ejidatario cuántas veces ha medido:

                    // Crear medición
                    state.addMeasurement(
                      precipitation: precipitation!,
                      time: dateTime,
                      image: newImage,
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    // Edita una medición ya existente
                    // TODO: que el usuario sólo pueda modificar su propia medición y no la de los demás usuario
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
          ),
        ],
      ),
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
                            : Text("⚠️ No ha seleccionado ninguna imágen ⚠️"),
                    ],
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
    );
  }
}
