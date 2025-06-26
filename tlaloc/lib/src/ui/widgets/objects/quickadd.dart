import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';

class QuickAddWidget extends StatelessWidget {
  const QuickAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            foregroundImage:
                FirebaseAuth.instance.currentUser?.photoURL != null
                    ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                    : const NetworkImage(
                      'https://s1.elespanol.com/2019/11/01/elandroidelibre/el_androide_libre_441218515_179632866_1024x576.jpg',
                    ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                // elevation: 0,
                // backgroundColor: WidgetStateProperty.all(Colors.transparent),
              ),
              onPressed:
                  () =>
                  // Ir a addscreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddScreen()),
                  ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Row(
                  children: [
                    Text(
                      'Sube una medición',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12,
                        // color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ButtonStyle(
              // elevation: 0,
              // backgroundColor: WidgetStateProperty.all(Colors.transparent),
            ),
            // Ir a commonselect
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CommonSelectPage(),
                  ),
                ),
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.qr_code, color: AppColors.blue1),
            ),
          ),
        ],
      ),
    );
  }
}
