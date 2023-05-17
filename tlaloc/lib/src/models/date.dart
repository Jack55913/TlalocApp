import 'package:flutter/material.dart';

class Datetime extends StatefulWidget {
  final void Function(DateTime) updateDateTime;

  const Datetime({
    Key? key,
    required this.updateDateTime,
  }) : super(key: key);

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
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.access_time,
              color: Colors.grey,
            ),
          ),
          title: Text(
            'Revisa la fecha de colecta',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontFamily: 'FredokaOne',
            ),
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
                label: Text(
                  '${dateTime.day}/${dateTime.month}/${dateTime.year}',
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
        ),
        //
        // ListTile(
        //   leading: CircleAvatar(
        //       backgroundColor: Colors.yellow[300],
        //       child:
        //           Icon(Icons.rocket_launch_rounded, color: Colors.yellow[900])),
        //   title: Text(
        //     'Elige un Rol',
        //   ),
        //   subtitle:
        //       Text('Estás en modo: ${Provider.of<AppState>(context).rol}'),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => RoleSelection()),
        //     );
        //   },
        // ),

        // Divider(
        //   height: 20,
        //   thickness: 1,
        // ),
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
