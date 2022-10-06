import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/datepicker.dart';

import '../../../resources/statics/graphs/graph1.dart';

class TlalocChips extends StatefulWidget {
  const TlalocChips({Key? key}) : super(key: key);

  @override
  State<TlalocChips> createState() => _TlalocChipsState();
}

class _TlalocChipsState extends State<TlalocChips> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            children: [
              ChoiceChip(
                selectedColor: AppColors.blue1,
                label: const SelectableText('Esta semana'),
                selected: mode == DateTimeMode.week,
                onSelected: (val) {
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final monday = now.add(Duration(days: -today.weekday + 1));
                  setState(() {
                    mode = DateTimeMode.week;
                    initialDate = monday;
                    finalDate = monday.add(const Duration(
                      days: 5,
                      hours: 23,
                      minutes: 59,
                      seconds: 59,
                    ));
                  });
                },
              ),
              const SizedBox(width: 4),
              ChoiceChip(
                selectedColor: AppColors.blue1,
                label: const SelectableText('Este mes'),
                selected: mode == DateTimeMode.month,
                onSelected: (val) {
                  final now = DateTime.now();
                  setState(() {
                    mode = DateTimeMode.month;
                    initialDate = DateTime(now.year, now.month, 1);
                    finalDate =
                        DateTime(now.year, now.month + 1, 0, 23, 59, 59);
                  });
                },
              ),
              const SizedBox(width: 4),
              ChoiceChip(
                selectedColor: AppColors.blue1,
                label: const SelectableText('Este año'),
                selected: mode == DateTimeMode.year,
                onSelected: (val) {
                  final now = DateTime.now();
                  setState(() {
                    mode = DateTimeMode.year;
                    initialDate = DateTime(now.year, 1, 1);
                    finalDate = DateTime(now.year, 12, 31, 23, 59, 59);
                  });
                },
              ),
              const SizedBox(width: 4),
              ChoiceChip(
                selectedColor: AppColors.blue1,
                label: const SelectableText('Siempre'),
                selected: mode == DateTimeMode.always,
                onSelected: (val) {
                  setState(() {
                    mode = DateTimeMode.always;
                    initialDate = dateLongAgo;
                    finalDate = dateInALongTime;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const SelectableText('Inicio: '),
              DatePickerButton(
                dateTime: initialDate,
                onDateChanged: (date) {
                  setState(() {
                    mode = DateTimeMode.custom;
                    initialDate = date;
                  });
                },
              ),
              const Expanded(
                child: SizedBox(),
              ),
              const SelectableText('Fin: '),
              DatePickerButton(
                dateTime: finalDate,
                onDateChanged: (date) {
                  setState(() {
                    mode = DateTimeMode.custom;
                    finalDate = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      23,
                      59,
                      59,
                    );
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
