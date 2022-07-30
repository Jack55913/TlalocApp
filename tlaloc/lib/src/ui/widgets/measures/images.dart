// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tlaloc/src/models/app_state.dart';

class ImageUploaderWidget extends StatefulWidget {
  final Measurement? measurement;
  const ImageUploaderWidget({Key? key, this.measurement}) : super(key: key);

  @override
  State<ImageUploaderWidget> createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
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
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
                    future: Connectivity().checkConnectivity(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError ||
                          (snapshot.hasData &&
                              snapshot.data == ConnectivityResult.none)) {
                        return const Text(
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
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.purple[300],
                                        child: Icon(Icons.image,
                                            color: Colors.purple[900])),
                                    title: const Text(" Desde la Galería",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'poppins',
                                        )),
                                    onTap: () {
                                      pickImage();
                                    }),
                                const SizedBox(height: 15),
                                ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.purple[300],
                                        child: Icon(Icons.camera_alt,
                                            color: Colors.purple[900])),
                                    title: const Text("Desde la Cámara",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'poppins',
                                        )),
                                    onTap: () {
                                      pickImageC();
                                    }),
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
                                      "⚠️ No ha seleccionado ninguna imágen ⚠️"),
                          ],
                        );
                      }
                    },
                  )
                  ;
  }
}
