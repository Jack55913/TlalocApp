import 'package:flutter/material.dart';

class Datetime extends StatefulWidget {
  final void Function(DateTime) updateDateTime;

  const Datetime({super.key, required this.updateDateTime});

  @override
  State<Datetime> createState() => _DatetimeState();
}

class _DatetimeState extends State<Datetime> {
  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
    widget.updateDateTime(value);
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Column(
      children: [
        ListTile(
          subtitle: const Text('4. La fecha y hora actual es:'),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CircleAvatar(
              backgroundColor: Colors.purple[300],
              child: Icon(Icons.access_time, color: Colors.purple[900]),
            ),
          ),
          title: const Text(
            'Revisa la fecha de colecta',
            style: TextStyle(fontSize: 18, fontFamily: 'FredokaOne'),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                    style: const TextStyle(),
                  ),
                ),
                onPressed: () async {
                  final date = await pickDate();
                  if (date == null) return;
                  final newDateTime = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    dateTime.hour,
                    dateTime.minute,
                  );
                  setState(() => dateTime = newDateTime);
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.access_time),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$hours:$minutes', style: const TextStyle()),
                ),
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
        ),

        const SizedBox(height: 16), 
      ],
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
