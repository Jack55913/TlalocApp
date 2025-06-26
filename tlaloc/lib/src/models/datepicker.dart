import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class DatePickerButton extends StatelessWidget {
  final DateTime dateTime;
  final void Function(DateTime) onDateChanged;

  const DatePickerButton({
    super.key,
    required this.dateTime,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_month),
      label: Text(
        (dateTime == dateLongAgo || dateTime == dateInALongTime)
            ? 'Seleccionar'
            : '${dateTime.year}/${dateTime.month}/${dateTime.day}',
      ),
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: (dateTime == dateLongAgo || dateTime == dateInALongTime)
              ? DateTime.now()
              : dateTime,
          firstDate: dateLongAgo,
          lastDate: dateInALongTime,
        );
        if (date != null) {
          onDateChanged(date);
        }
      },
    );
  }
}
