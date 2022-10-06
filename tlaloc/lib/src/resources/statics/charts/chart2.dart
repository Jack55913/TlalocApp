import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LegendTitleLineal extends StatefulWidget {
  const LegendTitleLineal({Key? key}) : super(key: key);

  @override
  State<LegendTitleLineal> createState() => _LegendTitleLinealState();
}

class _LegendTitleLinealState extends State<LegendTitleLineal> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData(2005, 11, 21, 31, 41, 51, 61, 71, 81, 91),
      ChartData(2006, 13, 23, 33, 43, 53, 63, 73, 83, 93),
      ChartData(2007, 29, 36, 49, 59, 69, 79, 89, 99, 109),
      ChartData(2008, 28, 38, 48, 68, 78, 88, 98, 108, 118),
      ChartData(2009, 35, 54, 64, 74, 84, 94, 104, 114, 124),
      ChartData(2010, 37, 57, 67, 77, 87, 97, 107, 117, 127),
      ChartData(2011, 50, 70, 80, 85, 90, 95, 100, 105, 110),
    ];
    return Center(
        child: SfCartesianChart(
            title: ChartTitle(
              text: 'Disperción de todos',
            ),
            legend: Legend(
                isVisible: true,
                // Overflowing legend content will be wraped
                overflowMode: LegendItemOverflowMode.wrap),
            series: <CartesianSeries<ChartData, int>>[
          LineSeries<ChartData, int>(
              name: 'El venturero',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series0),
          LineSeries<ChartData, int>(
              name: 'El Jardín',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series1),
          LineSeries<ChartData, int>(
              name: 'Cabaña',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series2),
          LineSeries<ChartData, int>(
              name: 'Cruz de Atenco',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series3),
          LineSeries<ChartData, int>(
              name: 'Canoas Altas',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series4),
          LineSeries<ChartData, int>(
              name: 'Canoas Altas',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series5),
          LineSeries<ChartData, int>(
              name: 'Los Manantiales',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series6),
          LineSeries<ChartData, int>(
              name: 'Tlaltlatlately',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series7),
          LineSeries<ChartData, int>(
              name: 'Agua de Chiqueros',
              color: Colors.red,
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.series8),
        ]));
  }
}

class ChartData {
  ChartData(
    this.x,
    this.series0,
    this.series1,
    this.series2,
    this.series3,
    this.series4,
    this.series5,
    this.series6,
    this.series7,
    this.series8,
  );
  final int x;
  final double series0;
  final double series1;
  final double series2;
  final double series3;
  final double series4;
  final double series5;
  final double series6;
  final double series7;
  final double series8;
}
