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

// class CommonAreaSeries extends StatefulWidget {
//   const CommonAreaSeries({super.key});

//   @override
//   State<CommonAreaSeries> createState() => _CommonAreaSeriesState();
// }

// enum DateTimeMode { custom, week, month, year, always }

// class _CommonAreaSeriesState extends State<CommonAreaSeries> {
//   DateTime initialDate = dateLongAgo;
//   DateTime finalDate = dateInALongTime;
//   DateTimeMode mode = DateTimeMode.always;

//   @override
//   Widget build(BuildContext context) {
//     final List<ChartData> chartData = <ChartData>[
//       ChartData(2010, 10.53, 3.3),
//       ChartData(2011, 9.5, 5.4),
//       ChartData(2012, 10, 2.65),
//       ChartData(2013, 9.4, 2.62),
//       ChartData(2014, 5.8, 1.99),
//       ChartData(2015, 4.9, 1.44),
//       ChartData(2016, 4.5, 2),
//       ChartData(2017, 3.6, 1.56),
//       ChartData(2018, 3.43, 2.1),
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
//                           child: Center(
//                               child: SfCartesianChart(series: <CartesianSeries>[
//                         SplineAreaSeries<ChartData, int>(
//                             dataSource: chartData,
//                             xValueMapper: (ChartData data, _) => data.x,
//                             yValueMapper: (ChartData data, _) => data.y),
//                         SplineAreaSeries<ChartData, int>(
//                             dataSource: chartData,
//                             xValueMapper: (ChartData data, _) => data.x,
//                             yValueMapper: (ChartData data, _) => data.y1),
//                       ])));
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
//   ChartData(this.x, this.y, this.y1);
//   final int x;
//   final double y;
//   final double y1;
// }
