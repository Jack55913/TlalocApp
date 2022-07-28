import 'package:flutter/material.dart';
import 'package:tlaloc/src/ui/widgets/buttons/save_button.dart';

class UserFormWidget extends StatefulWidget {
  const UserFormWidget({Key? key}) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}
// Sirve para enviar las mediciones
class _UserFormWidgetState extends State<UserFormWidget> {
  @override
  Widget build(BuildContext context) => Column(
    
    children: [
      buildSubmit(),
    ],
  );

  Widget buildSubmit() => ButtonWidget(
        onClicked: (){},
      );
}
