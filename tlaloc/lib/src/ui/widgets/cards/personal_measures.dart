// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';

class PersonalMeasures extends StatelessWidget {
  const PersonalMeasures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: AppColors.blue1, shape: BoxShape.circle),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20),
                AutoSizeText(
                  'Mediciones completadas',
                  style: TextStyle(
                    color: AppColors.blue1,
                    fontFamily: 'poppins',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                PersonalMeausreData(),
              ],
            ),
          ],
        ),
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: AppColors.blue1, shape: BoxShape.circle),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 20),
            AutoSizeText(
              'Mediciones Totales',
              style: TextStyle(
                color: AppColors.blue1,
                fontFamily: 'poppins',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
        Column(
          children: [
            PersonalMeausreData(),
          ],
        ),
      ],
    ),
      ],
    );
  }
}


class GeneralMeasures extends StatelessWidget {
  const GeneralMeasures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: AppColors.blue1, shape: BoxShape.circle),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20),
                AutoSizeText(
                  'Mediciones del paraje',
                  style: TextStyle(
                    color: AppColors.blue1,
                    fontFamily: 'poppins',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                PersonalMeausreData(),
              ],
            ),
          ],
        ),
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: AppColors.blue1, shape: BoxShape.circle),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 20),
            AutoSizeText(
              'Mediciones en el Monte',
              style: TextStyle(
                color: AppColors.blue1,
                fontFamily: 'poppins',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
        Column(
          children: [
            PersonalMeausreData(),
          ],
        ),
      ],
    ),
      ],
    );
  }
}