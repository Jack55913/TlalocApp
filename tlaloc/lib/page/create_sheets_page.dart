// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tlaloc/api/sheets/user_sheets_api.dart';
import 'package:tlaloc/models/user.dart';
import 'package:tlaloc/widgets/button_widget.dart';

class CreateSheetsPage extends StatelessWidget {
  const CreateSheetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MyApp.title'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          child: ButtonWidget(
            text: 'Guardar',
            onClicked: () async {
              final user = {
                UserFields.id: 1,
                UserFields.author: 'Emilio',
                UserFields.common: 'Texcoco'
              };
              await UserSheetsApi.insert([user]);
            },
          ),
        ),
      );
  Future insertUsers() async {
    final users = [
      User(id: 1, author: 'Emilio', common: 'tex'),
      User(id: 2, author: 'jhon', common: 'hola'),
      User(id: 3, author: 'ala', common: 'porque')
    ];
    final jsonUsers = users.map((user) => user.toJson()).toList();
    await UserSheetsApi.insert(jsonUsers);
  }
}
