// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:tlaloc/src/resources/onboarding/role.dart';
import 'package:tlaloc/src/ui/widgets/graphs/pluviometer.dart';

double _level = 10;

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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: true,
            autofocus: true,
            maxLength: 5,
            // TODO: Hacer que funcione de, "save_button.dart"
            // controller: controller,
            validator: RangeValidator(
              min: 0.0,
              max: 160.0,
              errorText: 'Debe ser entre 0 y 160',
            ),

            keyboardType: TextInputType.number,
            initialValue: precipitation?.toString() ?? '',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'FredokaOne',
            ),
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              icon: CircleAvatar(
                backgroundColor: Colors.blue[300],
                child: Icon(
                  Icons.cloud,
                  color: Colors.blue[900],
                ),
              ),
              helperText: 'Recuerda ubicarte al nivel del agua para observar',
              hintText: 'Ingresar Medición',
              // '$_level',
            ),
            onChanged: (value) {
              precipitation = num.tryParse(value);
            },
          ),
        ),
        // PluviometerText(),
        TlalocPluviometer(),
        Divider(
          height: 20,
          thickness: 1,
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red[300],
            child: Icon(
              Icons.place,
              color: Colors.red[900],
            ),
          ),
          title: Text('Elige un Paraje'),
          subtitle: Text(
              'Estás ubicado en: "${Provider.of<AppState>(context).paraje}"'),
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
        ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.brown[300],
              child:
                  Icon(Icons.rocket_launch_rounded, color: Colors.brown[900])),
          title: Text(
            'Elige un Rol',
          ),
          subtitle:
              Text('Estás en modo: ${Provider.of<AppState>(context).rol}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoleSelection()),
            );
          },
        ),
        Divider(
          height: 20,
          thickness: 1,
        ),
        ListTile(
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
