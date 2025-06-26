// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:tlaloc/src/models/app_state.dart';
// import 'package:tlaloc/src/models/constants.dart';
// import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
// import 'package:tlaloc/src/ui/widgets/chips/chips.dart';

// // import '../../../models/datepicker.dart';

// class StackedColumnChart extends StatefulWidget {
//   const StackedColumnChart({super.key});

//   @override
//   State<StackedColumnChart> createState() => _StackedColumnChartState();
// }

// enum DateTimeMode { custom, week, month, year, always }

// class _StackedColumnChartState extends State<StackedColumnChart> {
//   DateTime initialDate = dateLongAgo;
//   DateTime finalDate = dateInALongTime;
//   DateTimeMode mode = DateTimeMode.always;

//   @override
//   Widget build(BuildContext context) {
//     final List<ChartData> chartData = [
//       ChartData('China', 12, 10, 14, 20),
//       ChartData('USA', 14, 11, 18, 23),
//       ChartData('UK', 16, 10, 15, 20),
//       ChartData('Brazil', 18, 16, 18, 24)
//     ];
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const AutoSizeText(
//             'Dispercion entre parajes ',
//             style: TextStyle(
//               fontFamily: 'FredokaOne',
//               fontSize: 24,
//               letterSpacing: 2,
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             const SizedBox(height: 20),
//             const TlalocChips(),
//             Consumer<AppState>(
//               builder: (context, state, _) {
//                 return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                   stream:
//                       state.getMeasurementsStream(), // Just as on DataScreen
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return EmptyState('Error ${snapshot.error}');
//                     } else if (snapshot.hasData) {
//                       final measurementsSnapshot = snapshot.data!;
//                       final measurements =
//     state.getMeasurementsFromDocs(snapshot.data!.docs);
//                       final filteredMeasurements = measurements
//                           .where((measurement) =>
//                               (measurement.dateTime!.isAfter(initialDate) &&
//                                   measurement.dateTime!.isBefore(finalDate)))
//                           .toList();
//                       return Expanded(
//                         child: Center(
//                             child: SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 series: <CartesianSeries>[
//                               StackedColumnSeries<ChartData, String>(
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) => data.x,
//                                   yValueMapper: (ChartData data, _) => data.y1),
//                               StackedColumnSeries<ChartData, String>(
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) => data.x,
//                                   yValueMapper: (ChartData data, _) => data.y2),
//                               StackedColumnSeries<ChartData, String>(
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) => data.x,
//                                   yValueMapper: (ChartData data, _) => data.y3),
//                               StackedColumnSeries<ChartData, String>(
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) => data.x,
//                                   yValueMapper: (ChartData data, _) => data.y4)
//                             ])),
//                       );
//                     } else {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChartData {
//   ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
//   final String x;
//   final int y1;
//   final int y2;
//   final int y3;
//   final int y4;
// }
