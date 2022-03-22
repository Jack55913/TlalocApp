import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';

class Datetime extends StatefulWidget {
  const Datetime({Key? key}) : super(key: key);

  @override
  State<Datetime> createState() => _DatetimeState();
}

class _DatetimeState extends State<Datetime> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'FredokaOne',
            ),
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              icon: Icon(
                Icons.cloud,
                color: Colors.white,
              ),
              helperText: 'Recuerda tomar una fotografía',
              hintText: 'Precipitación en mm',
            ),
            keyboardType: TextInputType.number, //Mostrara teclado numérico
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Registra la fecha de colecta',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'FredokaOne',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.calendar_month, color: Colors.black),
                style: ElevatedButton.styleFrom(primary: AppColors.green1),
                label: Text(
                    '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  final date = await pickDate();
                  if (date == null) return;

                  final newDateTime = DateTime(date.year, date.month, date.day,
                      dateTime.hour, dateTime.minute);

                  setState(() => dateTime = newDateTime);
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.access_time, color: Colors.black),
                style: ElevatedButton.styleFrom(primary: AppColors.green1),
                label: Text('$hours:$minutes',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
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
