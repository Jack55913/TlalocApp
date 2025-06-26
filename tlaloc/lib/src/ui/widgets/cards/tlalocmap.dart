import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/cards/map.dart';
import 'package:tlaloc/src/ui/widgets/cards/paraje_info.dart';
import 'package:url_launcher/url_launcher.dart';

class TlalocMapData extends StatelessWidget {
  const TlalocMapData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '📍¿Cómo llegar?',
              style: TextStyle(
                color: AppColors.blue1,
                fontFamily: 'FredokaOne',
                fontSize: 24,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          // Sección del mapa
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/mapa3.jpg",
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 24),

          // Título del paraje
          Consumer<AppState>(
            builder:
                (context, state, child) => AutoSizeText(
                  state.paraje.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: 'FredokaOne',
                    // color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  maxLines: 1,
                ),
          ),
          const SizedBox(height: 16),

          // Sección de descripción
          Card(
            // color: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DESCRIPCIÓN DEL PARAJE',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      // color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ParajeInfoSection(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Acciones
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 12, // separación horizontal
                  runSpacing: 12, // separación vertical
                  children: [
                    _buildActionButton(
                      context,
                      icon: FontAwesomeIcons.google,
                      label: 'Google Maps',
                      color: Colors.red,
                      onPressed: () => _launchMapsUrl(context),
                    ),
                    _buildActionButton(
                      context,
                      icon: FontAwesomeIcons.mapLocationDot,
                      label: 'Wikiloc',
                      color: Colors.green,
                      onPressed:
                          () => launchUrl(
                            Uri.parse(
                              'https://es.wikiloc.com/rutas-mountain-bike/monitoreo-de-la-lluvia-ruta-2-141098082',
                            ),
                          ),
                    ),
                    _buildActionButton(
                      context,
                      icon: FontAwesomeIcons.filePdf,
                      label: 'PDF',
                      color: Colors.black,
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TlalocMap(),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        // foregroundColor: Colors.white,
        // side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: FaIcon(icon, color: color, size: 18),
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          // color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }

  void _launchMapsUrl(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);
    state.getCurrentParajeData().then((data) {
      final url = data['url'] ?? 'https://maps.app.goo.gl/Uu7XWHwcs73zVCbq5';
      launchUrl(Uri.parse(url));
    });
  }
}
