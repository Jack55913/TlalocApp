import 'package:flutter/material.dart';
import 'package:tlaloc/api/sheets/user_sheets_api.dart';


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
              insertUsers();
              //   final user = User(
              //     id: 1,
              //     author: 'Emilio Álvarez Herrera',
              //     common:
              //   );
              // await UserSheetsApi.insert([user.toJson()]);
            },
          ),
        ),
      );
  Future insertUsers() async {
    final jsonUsers = users.map().toList();
    await UserSheetsApi.insert(jsonUsers);
  }
}
