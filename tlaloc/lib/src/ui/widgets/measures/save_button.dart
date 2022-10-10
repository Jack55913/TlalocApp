import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class ButtonWidget extends StatefulWidget {
  final VoidCallback onClicked;

  const ButtonWidget({Key? key, required this.onClicked}) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isButtonActive = true;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;

      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onSurface: AppColors.green1,
          primary: AppColors.green1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed: isButtonActive
          ? () {
              setState(() => isButtonActive = false);
              controller.clear();
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const SelectableText('¿Seguro(a) que desea enviar?'),
                  content: const SelectableText(
                      'Usted está mandando el registro a la base de datos, puede eliminarlo posteriormente.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const SelectableText('Cancelar'),
                    ),
                    TextButton(
                      child: const SelectableText('Enviar'),
                      onPressed: widget.onClicked,
                    ),
                  ],
                ),
              );
            }
          : null,
      child: const Text('Guardar',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'FredokaOne',
            fontSize: 21,
          )),
    );
  }
}
