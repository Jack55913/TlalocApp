
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:tlaloc/src/models/custompathpainter.dart'; 

// class WaterLevelBar extends StatefulWidget {
//   final double waterLevel;
//   final double maxLevel;

//   const WaterLevelBar({
//     Key? key,
//     required this.waterLevel,
//     required this.maxLevel,
//   }) : super(key: key);

//   @override
//   State<WaterLevelBar> createState() => _WaterLevelBarState();
// }

// class _WaterLevelBarState extends State<WaterLevelBar>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // Necesario por AutomaticKeepAliveClientMixin

//     return LinearBarPointer(
//       value: widget.maxLevel,
//       enableAnimation: true,
//       thickness: 180,
//       offset: 18,
//       position: LinearElementPosition.outside,
//       color: Colors.transparent,
//       child: CustomPaint(
//         painter: CustomPathPainter(
//           color: Colors.blue,
//           waterLevel: widget.waterLevel,
//           maximumPoint: widget.maxLevel,
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true; // Mantiene el estado vivo al navegar
// }
