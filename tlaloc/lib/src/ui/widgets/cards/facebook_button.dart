import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.orange1,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
            const SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Image(
                image: AssetImage('assets/images/img-5.jpg'),
                fit: BoxFit.cover,
                width: 170,
                height: 150,
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
