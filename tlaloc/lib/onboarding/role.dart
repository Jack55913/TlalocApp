import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/onboarding/common_select.dart';

// TODO: Que se separen de los demás, osease hay 8 graficas para los que eligieron monitores y 8 gráficas para los que eligieron visitante.

class RoleSelection extends StatelessWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue3,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/img-3.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                const Text(
                  'Selecciona una opción',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'FredokaOne',
                    color: AppColors.lightBlue,
                  ),
                ),
                const SizedBox(height: 20),
                const AutoSizeText(
                  'Si recibiste una capacitación por partedel equipo, entonces elige MONITOR:',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.person_search,
                                    color: Colors.white,
                                  ),
                                  Text('Visitante'),
                                ],
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CommonSelectPage(),
                              ),
                            );
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                Text('Monitor'),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CommonSelectPage(),
                              ),
                            );
                          },
                        ),
                        //
                      ],
                    ),
                    const SizedBox(height: 50)
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
