import 'package:flutter/material.dart';
import 'package:tlaloc/widgets/button_widget.dart';

class UserFormWidget extends StatefulWidget {
  const UserFormWidget({Key? key}) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  @override
  Widget build(BuildContext context) => Column(
    
    children: [
      buildSubmit(),
    ],
  );

  Widget buildSubmit() => ButtonWidget(
        text: 'Guardar',
        onClicked: (){},
      );
}
