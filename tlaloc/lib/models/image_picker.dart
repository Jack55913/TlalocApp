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
  const MyAddPage({Key? key, required this.title}) : super(key: key);

  final String title;

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
            ButtonWidget(
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
          ]
          ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          Datetime(),
          const Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          SizedBox(
            height: 15,
          ),
          MaterialButton(
              color: AppColors.green1,
              child: Text("Elegir imágen de la Galería",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                pickImage();
              }),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
              color: AppColors.green1,
              child: Text("Elegir imágen desde la Cámara",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                pickImageC();
              }),
          const SizedBox(
            height: 16,
          ),
          image != null
              ? Image.file(image!)
              : Center(child: Text("No ha seleccionado ninguna imágen")),
          SizedBox(
            height: 30,
          ),
          const Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}
