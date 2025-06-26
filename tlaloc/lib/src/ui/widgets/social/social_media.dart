import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksWidget extends StatelessWidget {
  const SocialLinksWidget({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Conecta con nosotros',

          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SocialIconButton(
              icon: FontAwesomeIcons.whatsapp,
              label: 'WhatsApp',
              color: Colors.green,
              onPressed:
                  () => _launchURL(
                    'https://api.whatsapp.com/send?phone=5630908507',
                  ),
            ),
            _SocialIconButton(
              icon: Icons.facebook,
              label: 'Facebook',
              color: Colors.blueAccent,
              onPressed:
                  () => _launchURL(
                    'https://www.facebook.com/profile.php?id=100083233511805',
                  ),
            ),
            _SocialIconButton(
              icon: Icons.ondemand_video,
              label: 'YouTube',
              color: Colors.redAccent,
              onPressed:
                  () => _launchURL(
                    'https://www.youtube.com/@tlalocapp', // Cambia esto si tienes un enlace real
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filledTonal(
          onPressed: onPressed,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: color,
            fixedSize: const Size(56, 56),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
