// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  // final controller;
  final Icon icon;
  final TextInputType textInputType;
  final String hintText;
  final String helperText;
  final onChanged;
  final initialValue;
  final onEditingComplete;
  final controller;
  final focusNode;
  final suffixIcon;
  const MyTextFormField(
      {Key? key,
      required this.icon,
      required this.textInputType,
      required this.onChanged,
      this.hintText = '',
      this.helperText = '',
      this.suffixIcon,
      this.initialValue,
      this.focusNode,
      this.onEditingComplete,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          enableSuggestions: true,
          autocorrect: true,
          initialValue: initialValue,
          cursorColor: Colors.green,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'FredokaOne',
          ),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: icon,
            ),
            helperText: helperText,
            hintText: hintText,
          ),
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: textInputType,
          autofocus: true,
        ),
      ],
    );
  }
}
