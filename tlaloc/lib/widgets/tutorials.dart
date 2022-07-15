import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Widget _buildItem(String textTitle, String textsubtitle, String url) {
  return ListTile(
    title: Text(textTitle,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'poppins',
          fontSize: 15,
        )),
    subtitle: Text(
      textsubtitle,
      style: const TextStyle(color: Colors.white70),
    ),
    trailing: IconButton(
        color: Colors.white,
        icon: const Icon(
          Icons.open_in_new,
        ),
        onPressed: () async {
          launchUrl(Uri.parse(url));
        }),
  );
}

class TutorialWidget extends StatelessWidget {
  const TutorialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: AutoSizeText(
            'Tutoriales',
            style: TextStyle(
              color: AppColors.green1,
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildItem(
            '📖 Medición de datos',
            'Revisa los errores más comúnes al momento de medir',
            'https://tlaloc.web.app/'),
        _buildItem(
            '🚀 Enviar las mediciones',
            '¿Cómo enviar los datos en la app?',
            'https://youtu.be/PattwuN6AlA'),
        _buildItem(
            '🛠️ Realiza tu propio pluviómetro',
            'Es un instrumento para la medición de lluvia',
            'https://youtu.be/kDqaTwjJvME'),
        _buildItem('⛰️ Instalación', '¿Cómo instalar un pluviómetro?',
            'https://youtu.be/qZx-Z3_n4t8'),
      ],
    );
  }
}
