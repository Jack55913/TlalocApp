// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:tlaloc/src/resources/onboarding/role.dart';
import 'package:tlaloc/src/ui/widgets/graphs/pluviometer.dart';

class Datetime extends StatefulWidget {
  final void Function(DateTime) updateDateTime;
  final void Function(num?) updatePrecipitation;
  final void Function(bool?) updatePluviometer;
  final Measurement? measurement;
  const Datetime({
    Key? key,
    required this.updateDateTime,
    required this.updatePrecipitation,
    required this.updatePluviometer,
    this.measurement,
  }) : super(key: key);

  @override
  State<Datetime> createState() => _DatetimeState();
}

class _DatetimeState extends State<Datetime> {
  DateTime _dateTime = DateTime.now();
  num? _precipitation;
  bool _pluviometer = false;

  DateTime get dateTime => _dateTime;
  num? get precipitation => _precipitation;
  bool get pluviometer => _pluviometer;

  set dateTime(DateTime value) {
    _dateTime = value;
    widget.updateDateTime(value);
  }

  set precipitation(num? value) {
    _precipitation = value;
    widget.updatePrecipitation(value);
  }

  set pluviometer(bool value) {
    _pluviometer = value;
    widget.updatePluviometer(value);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.measurement != null) {
      dateTime = widget.measurement!.dateTime!;
      precipitation = widget.measurement!.precipitation;
      // pluviometer = widget.measurement!.pluviometer;
    }
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red[300],
            child: Icon(
              Icons.place,
              color: Colors.red[900],
            ),
          ),
          title: SelectableText('Elige un Paraje'),
          subtitle: SelectableText(
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
          title: TextFormField(
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            // autocorrect: true,
            // autofocus: true,
            maxLength: 5,
            // TODO: Hacer que funcione , "save_button.dart"
            // controller: controller,
            validator: RangeValidator(
              min: 0.0,
              max: 160.0,
              errorText: 'Debe ser entre 0 y 160',
            ),
          ),
        ),
        TlalocPluviometer(),
        // Divider(
        //   height: 20,
        //   thickness: 1,
        // ),
        // // TODO: Agregar el switch
        // SwitchListTile(
        //   title: SelectableText(
        //     'Vaciar pluviómetro',
        //   ),
        //   value: _pluviometer,
        //   secondary: CircleAvatar(
        //       backgroundColor: Colors.teal[300],
        //       child: Icon(Icons.water_drop, color: Colors.teal[900])),
        //   subtitle: SelectableText('Hacer sólo si eres monitor'),
        //   onChanged: (bool value) {
        //     setState(() => _pluviometer = value);
        //   },
        // ),
        // Divider(
        //   height: 20,
        //   thickness: 1,
        // ),
        // ListTile(
        //   leading: CircleAvatar(
        //       backgroundColor: Colors.yellow[300],
        //       child:
        //           Icon(Icons.rocket_launch_rounded, color: Colors.yellow[900])),
        //   title: SelectableText(
        //     'Elige un Rol',
        //   ),
        //   subtitle:
        //       SelectableText('Estás en modo: ${Provider.of<AppState>(context).rol}'),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => RoleSelection()),
        //     );
        //   },
        // ),
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
          title: SelectableText(
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
                label: SelectableText(
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
                label: SelectableText('$hours:$minutes',
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
