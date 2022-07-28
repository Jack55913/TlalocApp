import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';


class PhraseCard extends StatelessWidget {
  const PhraseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Go to InfoProyectPage
        Navigator.pushNamed(context, '/info');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                AppColors.blue1,
                AppColors.pruple1,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children:const [
                     Text(
                      '💧💧 Precipitación:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'FredokaOne',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                    'Es la caída de agua procedente de las nubes en estado líquido (lluvia y llovizna),  sólido (granizo) y semisólido (nieve). Es una parte importante de ciclo hidrológico, ya que sin la precipitación no habría agua en los ecosistemas, ni en los lugares en donde vivimos.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 15,
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'OMM (2008)',
                      textAlign: TextAlign.end,
                      style:  TextStyle(
                        color: Colors.white,
                        fontFamily: 'FredokaOne',
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: const[
                         Text(
                          'Ver más',
                          textAlign: TextAlign.end,
                          style:  TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                          ),
                        ),
                         Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
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