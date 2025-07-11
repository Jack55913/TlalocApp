// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tlaloc/src/models/app_state.dart';
// import 'package:tlaloc/src/models/constants.dart';
// import 'package:tlaloc/src/resources/statics/charts/chart2.dart';
// import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
// import 'package:tlaloc/src/ui/widgets/chips/chips.dart';

// class CommonsLineGraph extends StatefulWidget {
//   const CommonsLineGraph({super.key});

//   @override
//   State<CommonsLineGraph> createState() => _CommonsLineGraphState();
// }

// enum DateTimeMode { custom, week, month, year, always }

// class _CommonsLineGraphState extends State<CommonsLineGraph> {
//   DateTime initialDate = dateLongAgo;
//   DateTime finalDate = dateInALongTime;
//   DateTimeMode mode = DateTimeMode.always;

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
//                         child: Column(
//                           children: const [ 
//                             LegendTitleLineal(),
//                           ],
//                         ),
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
