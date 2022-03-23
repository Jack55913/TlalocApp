// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/api/sheets/user_sheets_api.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/date.dart';
import 'package:tlaloc/models/user.dart';
import 'package:tlaloc/widgets/button_widget.dart';

class MyAddPage extends StatefulWidget {
  const MyAddPage({Key? key}) : super(key: key);

  @override
  State<MyAddPage> createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

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
          backgroundColor: AppColors.dark2,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: ButtonWidget(
                text: 'Guardar',
                onClicked: () async {
                  final user = {
                    UserFields.id: 1,
                    UserFields.author: 'Emilio',
                    UserFields.common: 'Tequexquinahuac',
                  };
                  await UserSheetsApi.insert([user]);
                },
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Datetime(),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.white38,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                      child: Text("🖼️ Desde la Galería",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              color: Colors.white,
                              fontSize: 16)),
                      onPressed: () {
                        pickImage();
                      }),
                  MaterialButton(
                      // color: AppColors.green1,
                      child: Text("📷 Desde la Cámara",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'poppins',
                            color: Colors.white,
                          )),
                      onPressed: () {
                        pickImageC();
                      }),
                ],
              ),
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
              color: Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}
