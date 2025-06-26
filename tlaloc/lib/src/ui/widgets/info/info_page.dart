// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/ui/widgets/info/info.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:animations/animations.dart';

class FluidDialogWidget extends StatelessWidget {
  const FluidDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // color: Colors.white,
      tooltip: 'Más',
      onPressed: () {
        // The `showModal` function from the animations package is used instead of showDialog
        // because it has a cooler animation.
        showModal(
          context: context,
          builder: (context) => FluidDialog(
            // Use a custom curve for the alignment transition
            alignmentCurve: Curves.easeInOutCubicEmphasized,
            // Setting custom durations for all animations.
            sizeDuration: const Duration(milliseconds: 300),
            alignmentDuration: const Duration(milliseconds: 600),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 50),
            // Here we use another animation from the animations package instead of the default one.
            transitionBuilder: (child, animation) => FadeScaleTransition(
              animation: animation,
              child: child,
            ),
            // Configuring how the dialog looks.
            defaultDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8.0),
            ),
            // Setting the first dialog page.
            rootPage: FluidDialogPage(
              alignment: Alignment.topRight,
              builder: (context) => const InfoDialog(),
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.more_vert,
      ),
    );
  }
}
