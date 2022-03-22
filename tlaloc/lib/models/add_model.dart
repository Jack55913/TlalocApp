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
              padding: const EdgeInsets.all(14.0),
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
      body: Column(
        children: [
          Datetime(),
          const Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          const SizedBox(height: 15),
          const Text(
            'Imágen del pluviómetro',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'FredokaOne',
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                color: AppColors.green1,
                child: Text("Desde la Galería 🖼️",
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  pickImage();
                }),
            MaterialButton(
                color: AppColors.green1,
                child: Text("Desde la Cámara 📷",
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  pickImageC();
                }),
              ],
            ),
          ),
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
