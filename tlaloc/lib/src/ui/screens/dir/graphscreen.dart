import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/ui/widgets/appbar/drawer.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton2.dart';
import 'package:tlaloc/src/ui/widgets/appbar/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/datepicker.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({Key? key}) : super(key: key);

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

enum DateTimeMode { custom, week, month, year, always }

class _GraphsScreenState extends State<GraphsScreen> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Estadísticas',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          actions: const <Widget>[
            InfoButton2(),
            ProfilePage(),
          ],
        ),
        drawer: const DrawerApp(),
        body: SafeArea(
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
                              days: 6,
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
                            finalDate = DateTime(
                                now.year, now.month + 1, 0, 23, 59, 59);
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
                      stream: state
                          .getRealMeasurementsStream(), // Just as on DataScreen
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getRealMeasurementsFromSnapshot(
                                  measurementsSnapshot);
                          final filteredMeasurements = measurements
                              .where((measurement) => (measurement.dateTime!
                                      .isAfter(initialDate) &&
                                  measurement.dateTime!.isBefore(finalDate)))
                              .toList();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SfCartesianChart(
                                  title: ChartTitle(
                                    text: 'Pluviograma',
                                    textStyle: const TextStyle(
                                      fontFamily: 'FredokaOne',
                                      fontSize: 24,
                                    ),
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePanning: true,
                                  ),
                                  primaryXAxis: DateTimeAxis(
                                    title: AxisTitle(
                                      text: 'Fecha',
                                    ),
                                    // name: 'Fecha',
                                    intervalType: DateTimeIntervalType.days,
                                    // dateFormat: DateFormat.MMMd('es'),
                                  ),
                                  primaryYAxis: NumericAxis(
                                      title: AxisTitle(
                                          text: 'Precipitación (mm)')),
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
              // ),
              //   ),
            ),
          ),
        )

        // SingleChildScrollView(
        //   child: Column(
        //     children: const [

        //       // TableGraphs(),
        //     ],
        //   ),
        // ),

        // floatingActionButton: const Fab(),
        );
  }
}
