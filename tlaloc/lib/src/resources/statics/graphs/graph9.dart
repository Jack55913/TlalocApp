import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/chips/chips.dart';

// import '../../../models/datepicker.dart';


class MultipleCommonSeries extends StatefulWidget {
  const MultipleCommonSeries({Key? key}) : super(key: key);

  @override
  State<MultipleCommonSeries> createState() => _MultipleCommonSeriesState();
}

enum DateTimeMode { custom, week, month, year, always }

class _MultipleCommonSeriesState extends State<MultipleCommonSeries> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData('Germany', 128, 129, 101),
      ChartData('Russia', 123, 92, 93),
      ChartData('Norway', 107, 106, 90),
      ChartData('USA', 87, 95, 71),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Dispercion entre parajes ',
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
            
            const TlalocChips(),Consumer<AppState>(
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
                          child: Center(
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <CartesianSeries>[
                            ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y),
                            ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y1),
                            ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y2)
                          ])));
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

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}
