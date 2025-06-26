import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    setState(() => _isLoading = true);
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    try {
      await provider.googleLogin();
      if (provider.currentUser != null) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (_, __, ___) => const CommonSelectPage(),
            transitionsBuilder:
                (_, a, __, c) => FadeTransition(opacity: a, child: c),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.dark1.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Lottie.asset('assets/animation/bg-3.json', width: 40),
                const SizedBox(width: 10),
                const Text('Error', style: TextStyle(color: Colors.white)),
              ],
            ),
            content: Text(error, style: const TextStyle(color: Colors.white70)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.purple1,
      body: Stack(
        children: [
          // Fondo animado
          Positioned.fill(
            child: Lottie.asset(
              'assets/animation/bg-3.json',
              fit: BoxFit.cover,
            ),
          ),

          // Contenido principal
          Center(
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child:
                          isWide
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: AnimatedBuilder(
                                        animation: _controller,
                                        builder:
                                            (context, child) =>
                                                Transform.translate(
                                                  offset: Offset(
                                                    0,
                                                    10 * _controller.value,
                                                  ),
                                                  child: child,
                                                ),
                                        child: Image.asset(
                                          'assets/images/img-1-4.png',
                                          width: size.width * 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: _buildLoginCard(size)),
                                ],
                              )
                              : Column(
                                children: [
                                  // Logo animado
                                  AnimatedBuilder(
                                    animation: _controller,
                                    builder:
                                        (context, child) => Transform.translate(
                                          offset: Offset(
                                            0,
                                            10 * _controller.value,
                                          ),
                                          child: child,
                                        ),
                                    child: Image.asset(
                                      'assets/images/img-1-4.png',
                                      width: size.width * 0.8,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  _buildLoginCard(size),
                                ],
                              ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Iniciar sesión',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'FredokaOne',
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Conéctate para contribuir a la ciencia ciudadana',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 30),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    _isLoading
                        ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                        : ElevatedButton.icon(
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.red[400],
                          ),
                          label: const Text(
                            'Continuar con Google',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            foregroundColor: Colors.black87,
                            minimumSize: Size(size.width * 0.7, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black26,
                          ),
                          onPressed: () => _handleGoogleSignIn(context),
                        ),
              ),
              const SizedBox(height: 30),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap:
                      () => launchUrl(
                        Uri.parse('https://tlaloc.web.app/privacy/'),
                        mode: LaunchMode.inAppWebView,
                      ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Al continuar, aceptas nuestros\n',
                        ),
                        TextSpan(
                          text: 'Términos de servicio',
                          style: TextStyle(
                            color: Colors.blue[200],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' y '),
                        TextSpan(
                          text: 'Política de privacidad',
                          style: TextStyle(
                            color: Colors.blue[200],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
