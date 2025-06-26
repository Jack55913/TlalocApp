
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in_web/google_sign_in_web.dart' as gsw;

class GoogleSignInWebButton extends StatelessWidget {
  const GoogleSignInWebButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink(); // Solo para Web

    return HtmlElementView(
      viewType: 'google-signin-button',
    );
  }
}
