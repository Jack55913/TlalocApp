import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class PhraseCard extends StatelessWidget {
  const PhraseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Go to InfoProyectPage
        Navigator.pushNamed(context, '/info');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [AppColors.blue1, AppColors.purple1],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Acerca de 💧',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Ver más',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                    ),
                  ),
                  Icon(Icons.navigate_next, color: Colors.white, size: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
