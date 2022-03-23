// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/home_widget_classes.dart';
import 'package:tlaloc/screens/navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyTutorial();
  }
}

class MyTutorial extends StatelessWidget {
  const MyTutorial({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // elevation: 0,
          title: AutoSizeText('Tláloc App',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FredokaOne',
                fontSize: 24,
                letterSpacing: 2,
              )),
          actions: const <Widget>[
            InfoButton(),
            ProfilePage(),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 20),
          scrollDirection: Axis.vertical,
          children: [
            const Center(
              child: AutoSizeText('Realiza éstos pasos',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 229, 131, 1),
                    fontFamily: 'FredokaOne',
                    fontSize: 24,
                    letterSpacing: 2,
                  )),
            ),
            _buildItem(
                '🛠️ Realiza tu propio pluviómetro',
                'Es un instrumento para la medición de lluvia',
                'https://youtu.be/kDqaTwjJvME'),
            _buildItem(
                '⛰️ Instalación',
                'Coloca tu pluviómetro en un lugar estratégico',
                'https://youtu.be/qZx-Z3_n4t8'),
            _buildItem(
                '📖 Medición de datos',
                'Revisa los errores comúnes al momento de medir',
                'https://tlaloc-web.web.app/'),
            _buildItem(
                '🚀 Enviar las mediciones',
                'Sube los datos obtenidos en la App!',
                'https://tlaloc-web.web.app/'),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.white30,
            ),
            const PhraseCard(),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.white30,
            ),
            SizedBox(height:20),
            const DynamicTlalocMap(),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.white30,
            ),
            SizedBox(height:20),
            const ContactUsButton(),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.white30,
            ),
            SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}

Widget _buildItem(String textTitle, String textsubtitle, String url) {
  return ListTile(
    title: Text(textTitle,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'poppins',
          fontSize: 15,
        )),
    subtitle: Text(textsubtitle),
    trailing: IconButton(
        icon: const Icon(
          Icons.open_in_new,
        ),
        onPressed: () async {
          launch(url);
        }),
  );
}