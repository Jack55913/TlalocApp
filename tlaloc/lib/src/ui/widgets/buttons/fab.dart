import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

import '../../screens/dir/add.dart';

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      tooltip: 'Agregar Medición',
      highlightElevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder:
              (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.95,
                child: const AddScreen(),
              ),
        );
      },
      backgroundColor: AppColors.blue1,
      icon: const Icon(Icons.add, color: Colors.white),
      mouseCursor: WidgetStateMouseCursor.clickable,
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
