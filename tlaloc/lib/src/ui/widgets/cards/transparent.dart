import 'package:flutter/material.dart';

class TransparentIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? splashColor;
  final double? iconSize;

  const TransparentIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.splashColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Fondo transparente
      elevation: 0, // Elimina sombra por defecto
      child: InkWell(
        splashColor: splashColor ?? Theme.of(context).splashColor,
        borderRadius: BorderRadius.circular(100), // Forma circular para el efecto
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: iconSize ?? 24,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}