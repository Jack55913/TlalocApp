// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/onboarding/common_select.dart';
// TODO: que sólo aparezca la fecha: 7/jul/2022 y la hora con minutos: 7/jul/2022 12:00
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

    return Column(
      children: [
        ListTile(
          title: TextFormField(
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
              helperText: 'Recuerda ubicarte al nivel del agua para observar',
              hintText: 'Precipitación en mm',
            ),
            onChanged: (value) {
              precipitation = num.tryParse(value);
            },
            keyboardType: TextInputType.number, //Mostrara teclado numérico
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.place,
            color: Colors.red,
          ),
          title: Text('Elige un Paraje'),
          subtitle: Text(Provider.of<AppState>(context).paraje),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommonSelectPage()),
            );
          },
        ),
        Divider(
          height: 20,
          thickness: 1,
        ),
        Text(
          'Revisa la fecha de colecta',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'FredokaOne',
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Si no es correcta la hora, edítala:',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: 'poppins',
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
        ),
        SizedBox(
          height: 10,
        ),
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
