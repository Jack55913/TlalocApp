import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OneTimeGoogleButton extends StatefulWidget {
  final String message;

  const OneTimeGoogleButton({super.key, required this.message});

  @override
  State<OneTimeGoogleButton> createState() => _OneTimeGoogleButtonState();
}

class _OneTimeGoogleButtonState extends State<OneTimeGoogleButton> {
  bool _completed = false;
  final String _preferenceKey = 'google_button_completed';
  final String _driveLink = 'https://forms.gle/9nqkaR7hBSGrUVze6';

  @override
  void initState() {
    super.initState();
    _loadCompletionStatus();
  }

  Future<void> _loadCompletionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _completed = prefs.getBool(_preferenceKey) ?? false);
  }

  Future<void> _launchAndMarkCompleted() async {
    try {
      if (await canLaunchUrl(Uri.parse(_driveLink))) {
        await launchUrl(
          Uri.parse(_driveLink),
          mode: LaunchMode.externalApplication,
        );
        _markAsCompleted();
      }
    } catch (e) {
      if (!mounted) return; // ⬅Verificar si sigue montado antes de usar context
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al abrir el documento. Por favor reintenta'),
        ),
      );
    }
  }

  Future<void> _markAsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_preferenceKey, true);
    if (mounted) setState(() => _completed = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_completed) return const SizedBox.shrink();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF4285F4),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: _launchAndMarkCompleted,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, size: 28, color: Colors.white),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "¡Acción Requerida!",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  // color: Colors.black87,
                ),
              ),
              Text(
                widget.message,
                style: const TextStyle(
                  fontSize: 14,

                  //  color: Colors.black54
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
