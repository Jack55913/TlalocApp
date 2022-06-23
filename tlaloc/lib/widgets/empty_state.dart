/// De https://github.com/miyotl/miyotl/blob/master/lib/widgets/empty_state.dart

import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  final String? image;

  // ignore: use_key_in_widget_constructors
  const EmptyState(this.text, [this.image]);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Image.asset(
              image!,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'FredokaOne',
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
