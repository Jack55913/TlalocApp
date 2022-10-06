import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/chips/chips.dart';

class BubbleGraph extends StatefulWidget {
  const BubbleGraph({Key? key}) : super(key: key);

  @override
  State<BubbleGraph> createState() => _BubbleGraphState();
}

enum DateTimeMode { custom, week, month, year, always }

class _BubbleGraphState extends State<BubbleGraph> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Gráfica de Burbujas ',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const TlalocChips(),
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
                        child: Column(
                          children: [
                            SfCartesianChart(
                              primaryXAxis: DateTimeAxis(
                                name: 'Fecha',
                                intervalType: DateTimeIntervalType.days,
                                dateFormat: DateFormat.MMMd('es'),
                              ),
                              primaryYAxis:
                                  NumericAxis(name: 'Precipitación (mm)'),
                              series: <ChartSeries<Measurement, DateTime>>[
                                BubbleSeries<Measurement, DateTime>(
                                  xValueMapper: (measurement, _) =>
                                      measurement.dateTime,
                                  yValueMapper: (measurement, _) =>
                                      measurement.precipitation,
                                  dataSource: filteredMeasurements,
                                ),
                              ],
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
