// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

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
  const MyTextFormField({
    super.key,
    required this.icon,
    required this.textInputType,
    required this.onChanged,
    this.hintText = '',
    this.helperText = '',
    this.suffixIcon,
    this.initialValue,
    this.focusNode,
    this.onEditingComplete,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark3
                : Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          enableSuggestions: true,
          autocorrect: true,
          initialValue: initialValue,
          // cursorColor: Colors.green,
          style: const TextStyle(fontSize: 18, fontFamily: 'FredokaOne'),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            icon: CircleAvatar(
              backgroundColor: Colors.blueGrey[100],
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
      ),
    );
  }
}
