import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/onboarding/common_select.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue3,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/img-3.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const Text(
                  'Selecciona una opción',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'FredokaOne',
                    color: AppColors.lightBlue,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const[
                    RoleSelectionWidget(
                      // icon: 'e67c',
                      textTitle: 'Visitante',
                      textsubtitle: 'Si es la primera vez\nque usas la app',
                    ),
                    RoleSelectionWidget(
                      // icon: 'e61f',
                      textTitle: 'Monitor',
                      textsubtitle: 'Si has cursado\nuna capacitación',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleSelectionWidget extends StatelessWidget {
  // final String icon;
  final String textTitle;
  final String textsubtitle;
  const RoleSelectionWidget(
      {Key? key,
      // required this.icon,
      required this.textTitle,
      required this.textsubtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CommonSelectPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListTile(
          title: Row(
            children: [
              // Icon(
              //   IconData(int.parse('0x$icon'), fontFamily: 'MaterialIcons',),
              //   color: Colors.white,
              // ),
              Text(textTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontSize: 15,
                  )),
            ],
          ),
          subtitle: Text(
            textsubtitle,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
