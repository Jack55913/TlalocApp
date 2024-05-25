import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';

class QuickAddWidget extends StatelessWidget {
  const QuickAddWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
                // elevation: 0, 
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                ),
            onPressed: () =>
                // Ir a addscreen
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddScreen(),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Sube una medición',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          // Ir a commonselect
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CommonSelectPage(),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: AppColors.dark3,
            child: Icon(Icons.qr_code, color: AppColors.blue1),
          ),
        ),
      ],
    );
  }
}
