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
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.green1),
          // TODO
          
          // disabledForegroundColor: MaterialStateProperty.all(AppColors.green1.withOpacity(0.38)),
          // disabledBackgroundColor: MaterialStateProperty.all(AppColors.green1.withOpacity(0.12)),
          
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
              
              ),
      onPressed: isButtonActive
          ? () {
              setState(() => isButtonActive = false);
              controller.clear();
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('¿Seguro(a) que desea enviar?'),
                  content: const Text(
                      'Usted está mandando el registro a la base de datos, puede eliminarlo posteriormente.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: widget.onClicked,
                      child: const Text('Enviar'),
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
