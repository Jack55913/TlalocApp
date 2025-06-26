// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  // final bool showDivider;
  final double blurIntensity;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 15.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    // this.showDivider = true,
    this.blurIntensity = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color containerColor = isDark ? AppColors.dark3 : Colors.white70;

    return Column(
      children: [
        Container(
          margin: margin,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(borderRadius),
            // border: Border.all(
            //   color: isDark ? Colors.white70 : AppColors.dark3,
            //   width: 1,
            // ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(padding: padding, child: child),
          ),
        ),
        // if (showDivider) Divider(height: 20, thickness: 4, color: Colors.black),
      ],
    );
  }
}
