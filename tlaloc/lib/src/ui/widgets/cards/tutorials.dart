import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Widget _buildItem(String textTitle, String textsubtitle, String url) {
  return ListTile(
    onTap: () async {
      launchUrl(Uri.parse(url));
    },
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
    trailing: const Icon(
      Icons.open_in_new,
      color: Colors.white,
    ),
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
            'Tutoriales 🎥 📼',
            style: TextStyle(
              color: AppColors.blue1,
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildItem(
            '🛠️ Presentación del Proyecto',
            'Conoce más a fondo nuestras causas',
            'https://youtu.be/kDqaTwjJvME'),
        _buildItem(
            '📖 Medición de datos',
            'Revisa los errores más comúnes al momento de medir',
            'https://youtu.be/V1Jj0qdJ_fQ'),
        _buildItem(
            '🚀 Enviar las mediciones',
            '¿Cómo enviar los datos en la app?',
            'https://youtu.be/4hyi5jvvLOs'),
        _buildItem('⛰️ Instalación', '¿Cómo instalar un pluviómetro?',
            // TODO: CAMBIAR LOS VIDEOS REALES:
            'https://youtu.be/qZx-Z3_n4t8'),
      ],
    );
  }
}