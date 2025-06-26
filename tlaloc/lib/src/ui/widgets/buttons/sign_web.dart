// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

// class GoogleSignInWebButton extends StatelessWidget {
//   const GoogleSignInWebButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     if (!kIsWeb) return const SizedBox.shrink();

//     // Registrar el viewType solo si aún no existe (por seguridad)
//     // Esto generalmente debe hacerse una vez en `main`, pero lo incluimos por si acaso
//     ui.platformViewRegistry.registerViewFactory(
//       'google-signin-button',
//       (int viewId) => GoogleSignInPlugin().renderButton(),
//     );

//     return SizedBox(
//       height: 60,
//       width: 300,
//       child: HtmlElementView(viewType: 'google-signin-button'),
//     );
//   }
// }
