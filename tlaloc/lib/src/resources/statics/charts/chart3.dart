// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import 'package:tlaloc/src/models/app_state.dart';
// import 'package:tlaloc/src/models/constants.dart';
// import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';

// import '../../../models/datepicker.dart';
// import '../graphs/graph1.dart';

// class TrackballGraph extends StatefulWidget {
//   const TrackballGraph({Key? key}) : super(key: key);

//   @override
//   State<TrackballGraph> createState() => _TrackballGraphState();
// }

// class _TrackballGraphState extends State<TrackballGraph> {
//   late TrackballBehavior _trackballBehavior;
//   final List<ChartData> data = <ChartData>[
//     ChartData('Jan', 15, 39, 60),
//     ChartData('Feb', 20, 30, 55),
//     ChartData('Mar', 25, 28, 48),
//     ChartData('Apr', 21, 35, 57),
//     ChartData('May', 13, 39, 62),
//     ChartData('Jun', 18, 41, 64),
//     ChartData('Jul', 24, 45, 57),
//     ChartData('Aug', 23, 48, 53),
//     ChartData('Sep', 19, 54, 63),
//     ChartData('Oct', 31, 55, 50),
//     ChartData('Nov', 39, 57, 66),
//     ChartData('Dec', 50, 60, 65),
//   ];
//   DateTime initialDate = dateLongAgo;
//   DateTime finalDate = dateInALongTime;
//   DateTimeMode mode = DateTimeMode.always;

//   @override
//   void initState() {
//     _trackballBehavior = TrackballBehavior(
//         enable: true, tooltipDisplayMode: TrackballDisplayMode.groupAllPoints);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
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
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Wrap(
//                 children: [
//                   ChoiceChip(
//                     selectedColor: AppColors.blue1,
//                     label: const Text('Esta semana'),
//                     selected: mode == DateTimeMode.week,
//                     onSelected: (val) {
//                       final now = DateTime.now();
//                       final today = DateTime(now.year, now.month, now.day);
//                       final monday =
//                           now.add(Duration(days: -today.weekday + 1));
//                       setState(() {
//                         mode = DateTimeMode.week;
//                         initialDate = monday;
//                         finalDate = monday.add(const Duration(
//                           days: 5,
//                           hours: 23,
//                           minutes: 59,
//                           seconds: 59,
//                         ));
//                       });
//                     },
//                   ),
//                   const SizedBox(width: 4),
//                   ChoiceChip(
//                     selectedColor: AppColors.blue1,
//                     label: const Text('Este mes'),
//                     selected: mode == DateTimeMode.month,
//                     onSelected: (val) {
//                       final now = DateTime.now();
//                       setState(() {
//                         mode = DateTimeMode.month;
//                         initialDate = DateTime(now.year, now.month, 1);
//                         finalDate =
//                             DateTime(now.year, now.month + 1, 0, 23, 59, 59);
//                       });
//                     },
//                   ),
//                   const SizedBox(width: 4),
//                   ChoiceChip(
//                     selectedColor: AppColors.blue1,
//                     label: const Text('Este año'),
//                     selected: mode == DateTimeMode.year,
//                     onSelected: (val) {
//                       final now = DateTime.now();
//                       setState(() {
//                         mode = DateTimeMode.year;
//                         initialDate = DateTime(now.year, 1, 1);
//                         finalDate = DateTime(now.year, 12, 31, 23, 59, 59);
//                       });
//                     },
//                   ),
//                   const SizedBox(width: 4),
//                   ChoiceChip(
//                     selectedColor: AppColors.blue1,
//                     label: const Text('Siempre'),
//                     selected: mode == DateTimeMode.always,
//                     onSelected: (val) {
//                       setState(() {
//                         mode = DateTimeMode.always;
//                         initialDate = dateLongAgo;
//                         finalDate = dateInALongTime;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Row(
//                 children: [
//                   const Text('Inicio: '),
//                   DatePickerButton(
//                     dateTime: initialDate,
//                     onDateChanged: (date) {
//                       setState(() {
//                         mode = DateTimeMode.custom;
//                         initialDate = date;
//                       });
//                     },
//                   ),
//                   const Expanded(
//                     child: SizedBox(),
//                   ),
//                   const Text('Fin: '),
//                   DatePickerButton(
//                     dateTime: finalDate,
//                     onDateChanged: (date) {
//                       setState(() {
//                         mode = DateTimeMode.custom;
//                         finalDate = DateTime(
//                           date.year,
//                           date.month,
//                           date.day,
//                           23,
//                           59,
//                           59,
//                         );
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
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
//                       final measurements = state
//                           .getMeasurementsFromSnapshot(measurementsSnapshot);
//                       final filteredMeasurements = measurements
//                           .where((measurement) =>
//                               (measurement.dateTime!.isAfter(initialDate) &&
//                                   measurement.dateTime!.isBefore(finalDate)))
//                           .toList();
//                       return Expanded(
//                           child: SfCartesianChart(
//                               primaryXAxis: CategoryAxis(),
//                               trackballBehavior: _trackballBehavior,
//                               series: <LineSeries<ChartData, String>>[
//                             LineSeries<ChartData, String>(
//                               dataSource: data,
//                               markerSettings:
//                                   const MarkerSettings(isVisible: true),
//                               name: 'United States of America',
//                               xValueMapper: (ChartData sales, _) => sales.month,
//                               yValueMapper: (ChartData sales, _) =>
//                                   sales.firstSale,
//                             ),
//                             LineSeries<ChartData, String>(
//                               dataSource: data,
//                               markerSettings:
//                                   const MarkerSettings(isVisible: true),
//                               name: 'Germany',
//                               xValueMapper: (ChartData sales, _) => sales.month,
//                               yValueMapper: (ChartData sales, _) =>
//                                   sales.secondSale,
//                             ),
//                             LineSeries<ChartData, String>(
//                               dataSource: data,
//                               markerSettings:
//                                   const MarkerSettings(isVisible: true),
//                               name: 'United Kingdom',
//                               xValueMapper: (ChartData sales, _) => sales.month,
//                               yValueMapper: (ChartData sales, _) =>
//                                   sales.thirdSale,
//                             )
//                           ]));
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
//   ChartData(this.month, this.firstSale, this.secondSale, this.thirdSale);

//   final String month;
//   final double firstSale;
//   final double secondSale;
//   final double thirdSale;
// }
