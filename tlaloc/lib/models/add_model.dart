// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/api/sheets/user_sheets_api.dart';
import 'package:tlaloc/models/date.dart';
import 'package:tlaloc/models/user.dart';
import 'package:tlaloc/widgets/button_widget.dart';

import 'app_state.dart';

class MyAddPage extends StatefulWidget {
  const MyAddPage({Key? key}) : super(key: key);

  @override
  State<MyAddPage> createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  File? image;
  DateTime dateTime = DateTime.now();
  int? precipitation;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final File imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Falló al obtener la imágen: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Falló al obtener la imágen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: ButtonWidget(
              text: 'Guardar',
              onClicked: () async {
                final state = Provider.of<AppState>(context, listen: false);
                state.addMeasurement(
                  precipitation: precipitation!,
                  time: dateTime,
                );
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
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            const SizedBox(height: 15),
            const Text(
              'Imágen del pluviómetro',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'FredokaOne',
              ),
            ),
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
                        Text(" Desde la Cámara",
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
            SizedBox(height: 15),
            image != null
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.file(image!))
                : Text("⚠️ No ha seleccionado ninguna imágen ⚠️"),
            SizedBox(
              height: 30,
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
