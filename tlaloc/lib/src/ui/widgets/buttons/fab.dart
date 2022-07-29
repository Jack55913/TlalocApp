import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

import '../../screens/dir/add.dart';

class Fab extends StatelessWidget {
  const Fab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      tooltip: 'Agregar Medición',
      highlightElevation: 1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const AddScreen()),
        );
      },
      backgroundColor: AppColors.green1,
      icon: const Icon(Icons.add, color: Colors.white),
      mouseCursor: MaterialStateMouseCursor.clickable,
      label: const Text(
        'Agregar',
        style: TextStyle(
          fontFamily: 'poppins',
          fontSize: 18,
          letterSpacing: 2,
          color: Colors.white,
        ),
      ),
    );
  }
}