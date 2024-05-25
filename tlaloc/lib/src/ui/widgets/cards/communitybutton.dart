import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class CommunityButton extends StatelessWidget {
  const CommunityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.orange1,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Todos podemos \nPARTICIPAR',
                    // 'Descúbre un grupo\npara preservar\nel monte Tláloc',
                    style: TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Explora las acciones\n y unamos fuerzas\nMás información aquí',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Image(
                // TODO: CAMBIAR FOTO||
                image: AssetImage('assets/images/img-5.jpg'),
                fit: BoxFit.fill,
                // width: 200,
                height: 250,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/community');
      },
    );
  }
}
