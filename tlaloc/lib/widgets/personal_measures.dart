// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';

class PersonalMeasures extends StatefulWidget {
  const PersonalMeasures({Key? key}) : super(key: key);

  @override
  State<PersonalMeasures> createState() => _PersonalMeasuresState();
}

class _PersonalMeasuresState extends State<PersonalMeasures> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dark2,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.blue1, shape: BoxShape.circle),
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
              Text(
                '$_counter',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
