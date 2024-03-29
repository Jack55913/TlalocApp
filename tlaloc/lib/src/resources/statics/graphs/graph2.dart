// import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/datepicker.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
// import 'package:tlaloc/src/ui/widgets/chips/chips.dart';

/// Samples:
/// https://google.github.io/charts/flutter/example/time_series_charts/simple.html
/// https://www.syncfusion.com/kb/12289/how-to-render-flutter-time-series-chart-using-the-charts-widget-sfcartesianchart
/// https://pub.dev/packages/syncfusion_flutter_charts/example

class BarGraph extends StatefulWidget {
  const BarGraph({Key? key}) : super(key: key);

  @override
  State<BarGraph> createState() => _BarGraphState();
}

enum DateTimeMode { custom, week, month, year, always }

class _BarGraphState extends State<BarGraph> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        //   child: Scaffold(
        //     appBar: AppBar(
        //       title: const AutoSizeText(
        //         'Gráfica de Barras ',
        //         style: TextStyle(
        //           fontFamily: 'FredokaOne',
        //           fontSize: 24,
        //           letterSpacing: 2,
        //         ),
        //       ),
        //     ),
        //     body:
        SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                children: [
                  ChoiceChip(
                    selectedColor: AppColors.blue1,
                    label: const Text('Esta semana'),
                    selected: mode == DateTimeMode.week,
                    onSelected: (val) {
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final monday =
                          now.add(Duration(days: -today.weekday + 1));
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
                    label: const Text('Este mes'),
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
                    label: const Text('Este año'),
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
                    label: const Text('Siempre'),
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
                  const Text('Inicio: '),
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
                  const Text('Fin: '),
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
            const SizedBox(height: 20),
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
                      return Column(
                        children: [
                          SfCartesianChart(
                            title: ChartTitle(
                              text: 'Gráfica de Barras',
                              textStyle: const TextStyle(
                                fontFamily: 'FredokaOne',
                                fontSize: 24,
                              ),
                            ),
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePanning: true,
                            ),
                            primaryXAxis: DateTimeAxis(
                              name: 'Fecha',
                              intervalType: DateTimeIntervalType.days,
                              dateFormat: DateFormat.MMMd('es'),
                            ),
                            primaryYAxis:
                                NumericAxis(name: 'Precipitación (mm)'),
                            series: <ChartSeries<Measurement, DateTime>>[
                              ColumnSeries<Measurement, DateTime>(
                                xValueMapper: (measurement, _) =>
                                    measurement.dateTime,
                                yValueMapper: (measurement, _) =>
                                    measurement.precipitation,
                                dataSource: filteredMeasurements,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
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
          // ),
          //   ),
        ),
      ),
    );
  }
}
