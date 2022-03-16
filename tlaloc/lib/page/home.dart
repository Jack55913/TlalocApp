import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:tlaloc/screens/settings.dart';
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
              color: Colors.black26,
            ),
            const PhraseCard(),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black26,
            ),
            // const PhraseCard(),
            const ContactUsButton(),
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

class PhraseCard extends StatelessWidget {
  const PhraseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //Poner fondo con gradiente
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(0, 229, 131, 1),
              Color.fromRGBO(44, 42, 107, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(50.0),
          child: Text(
              'La captación de agua de lluvia, es la solución caida del cielo. Ésto implica que debemos cuidar los bosques, porque son ellos los reguladores hidrológicos más importantes',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 15,
              )),
        ),
      ),
    );
  }
}

class MeditionDataShow extends StatelessWidget {
  const MeditionDataShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          Text('Medición de datos',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 15,
              )),
          Text('Revisa los errores comúnes al momento de medir',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          launch('mailto:tlloc-app@googlegroups.com');
        },
        child: const Text(
          'Contactanos',
        ),
      ),
    );
  }
}
