import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class ButtonWidget extends StatefulWidget {
  final VoidCallback onClicked;

  const ButtonWidget({super.key, required this.onClicked});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showConfirmationDialog(context),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.lightBlue,
        textStyle: const TextStyle(fontFamily: 'FredokaOne', fontSize: 24),
      ),
      child: const Text('Guardar'),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: AppColors.dark2,
            title: const Text('¿Seguro(a) que desea enviar?'),
            content: const Text(
              'Usted está mandando el registro a la base de datos, puede eliminarlo posteriormente.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onClicked();
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
    );
  }
}
