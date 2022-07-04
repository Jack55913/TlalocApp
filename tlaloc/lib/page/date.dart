// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tlaloc/models/app_state.dart';

class Datetime extends StatefulWidget {
  final void Function(DateTime) updateDateTime;
  final void Function(num?) updatePrecipitation;
  final Measurement? measurement;
  const Datetime({
    Key? key,
    required this.updateDateTime,
    required this.updatePrecipitation,
    this.measurement,
  }) : super(key: key);

  @override
  State<Datetime> createState() => _DatetimeState();
}

class _DatetimeState extends State<Datetime> {
  DateTime _dateTime = DateTime.now();
  num? _precipitation;

  DateTime get dateTime => _dateTime;
  num? get precipitation => _precipitation;

  set dateTime(DateTime value) {
    _dateTime = value;
    widget.updateDateTime(value);
  }

  set precipitation(num? value) {
    _precipitation = value;
    widget.updatePrecipitation(value);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.measurement != null) {
      dateTime = widget.measurement!.dateTime!;
      precipitation = widget.measurement!.precipitation;
    }

    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: precipitation?.toString() ?? '',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'FredokaOne',
            ),
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              icon: Icon(
                Icons.cloud,
              ),
              helperText: 'Recuerda tomar una fotografía',
              hintText: 'Precipitación en mm',
            ),
            onChanged: (value) {
              precipitation = num.tryParse(value);
            },
            keyboardType: TextInputType.number, //Mostrara teclado numérico
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Revisa la fecha de colecta',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'FredokaOne',
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Si no es correcta, edítala:',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'FredokaOne',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                ),
                onPressed: () async {
                  final date = await pickDate();
                  if (date == null) return;

                  final newDateTime = DateTime(date.year, date.month, date.day,
                      dateTime.hour, dateTime.minute);

                  setState(() => dateTime = newDateTime);
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.access_time, color: Colors.white),
                // style: ElevatedButton.styleFrom(primary: Colors.transparent),
                label: Text('$hours:$minutes',
                    style: const TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () async {
                  final time = await pickTime();
                  if (time == null) return;
                  final newDateTime = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day,
                    time.hour,
                    time.minute,
                  );
                  setState(() => dateTime = newDateTime);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
