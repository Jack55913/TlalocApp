import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialWidget extends StatelessWidget {
  const TutorialWidget({super.key});

  Widget _buildItem(
    BuildContext context,
    String textTitle,
    String textSubtitle,
    String url,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.blue1,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          textTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            // color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          textSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            // color: Colors.white70,
          ),
        ),
        trailing: const Icon(
          Icons.open_in_new,
          // color: Colors.white
        ),
        onTap: () async {
          await launchUrl(Uri.parse(url));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: AutoSizeText(
            'Tutoriales 📽️',
            style: TextStyle(
              color: AppColors.blue1,
              fontFamily: 'FredokaOne',
              fontSize: 26,
              letterSpacing: 1.5,
            ),
          ),
        ),
        _buildItem(
          context,
          'Bienvenida',
          'Participa con nosotros en el monitoreo de agua de lluvia en el Monte Tláloc',
          'https://fb.watch/rWvSWd16SB/',
          Icons.play_circle_fill,
        ),
        _buildItem(
          context,
          'Presentación del Proyecto',
          'Conoce más a fondo nuestras causas',
          'https://fb.watch/jCUYwEVpWq/',
          Icons.info_outline,
        ),
        _buildItem(
          context,
          'Medición de datos',
          'Revisa los errores más comunes al medir',
          'https://youtu.be/V1Jj0qdJ_fQ',
          Icons.bar_chart,
        ),
        _buildItem(
          context,
          'Enviar las mediciones',
          '¿Cómo enviar los datos en la app?',
          'https://youtu.be/4hyi5jvvLOs',
          Icons.send_rounded,
        ),
      ],
    );
  }
}
