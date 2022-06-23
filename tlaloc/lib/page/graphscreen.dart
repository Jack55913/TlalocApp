import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlaloc/widgets/empty_state.dart';
import '../models/app_state.dart';
// import 'package:intl/intl.dart';

/// Samples:
/// https://google.github.io/charts/flutter/example/time_series_charts/simple.html
/// https://www.syncfusion.com/kb/12289/how-to-render-flutter-time-series-chart-using-the-charts-widget-sfcartesianchart
/// https://pub.dev/packages/syncfusion_flutter_charts/example

class DatePickerButton extends StatefulWidget {
  final DateTime initialDate;
  final void Function(DateTime) onDateChanged;

  const DatePickerButton({
    Key? key,
    required this.initialDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime? _dateTime;

  DateTime get dateTime => _dateTime!;
  set dateTime(value) => _dateTime = value;

  @override
  Widget build(BuildContext context) {
    _dateTime ??= widget.initialDate;
    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_month),
      label: Text(
        '${dateTime.year}/${dateTime.month}/${dateTime.day}',
      ),
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: (dateTime == DateTime(2000, 1, 1) ||
                  dateTime == DateTime(3000, 12, 31))
              ? DateTime.now()
              : dateTime,
          firstDate: DateTime(2000, 1, 1),
          lastDate: DateTime(3000, 12, 31),
        );
        if (date != null) {
          setState(() {
            dateTime = date;
          });
          widget.onDateChanged(date);
        }
      },
    );
  }
}

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({Key? key}) : super(key: key);

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  DateTime initialDate = DateTime(2000, 1, 1);
  DateTime finalDate = DateTime(3000, 12, 31);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Gráfica',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Text('Inicio: '),
                DatePickerButton(
                  initialDate: initialDate,
                  onDateChanged: (date) {
                    setState(() {
                      initialDate = date;
                    });
                  },
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                const Text('Fin: '),
                DatePickerButton(
                  initialDate: finalDate,
                  onDateChanged: (date) {
                    setState(
                      () {
                        finalDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          23,
                          59,
                          59,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Consumer<AppState>(
              builder: (context, state, _) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream:
                      state.getMeasurementsStream(), // Just as on DataScreen
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return EmptyState('Error ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final measurementsSnapshot = snapshot.data!;
                      final measurements = state
                          .getMeasurementsFromSnapshot(measurementsSnapshot);
                      final filteredMeasurements = measurements
                          .where((measurement) =>
                              (measurement.dateTime!.isAfter(initialDate) &&
                                  measurement.dateTime!.isBefore(finalDate)))
                          .toList();
                      return Expanded(
                        child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(
                            name: 'Fecha',
                            intervalType: DateTimeIntervalType.days,

                            /// TODO: dateFormat para que esté en español
                          ),
                          primaryYAxis: NumericAxis(name: 'Precipitación (mm)'),
                          series: <ChartSeries<Measurement, DateTime>>[
                            LineSeries<Measurement, DateTime>(
                              xValueMapper: (measurement, _) =>
                                  measurement.dateTime,
                              yValueMapper: (measurement, _) =>
                                  measurement.precipitation,
                              dataSource: filteredMeasurements,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
