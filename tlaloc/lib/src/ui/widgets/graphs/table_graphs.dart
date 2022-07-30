// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tlaloc/src/resources/page/graphs/graph1.dart';
import 'package:tlaloc/src/resources/page/graphs/graph2.dart';
import 'package:tlaloc/src/resources/page/graphs/graph3.dart';
import 'package:tlaloc/src/resources/page/graphs/graph4.dart';
import 'package:tlaloc/src/resources/page/graphs/graph5.dart';
import 'package:tlaloc/src/resources/page/graphs/graph6.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/graphs/menugraphs.dart';
// import 'package:tlaloc/page/graphs/graph2.dart';

class TableGraphs extends StatefulWidget {
  const TableGraphs({Key? key}) : super(key: key);

  @override
  State<TableGraphs> createState() => _TableGraphsState();
}

List<Icon> graphIcons = [
  Icon(Icons.show_chart, color: Colors.blue[300]),
  Icon(Icons.area_chart, color: Colors.green[300]),
  Icon(Icons.bar_chart, color: Colors.red[300]),
  Icon(Icons.bubble_chart_rounded, color: Colors.orange[300]),
  Icon(Icons.pie_chart, color: Colors.purple[300]),
  Icon(Icons.stacked_line_chart_rounded, color: Colors.pink[300]),
];

List<Color> grpahIconColor = [
  Color.fromARGB(255, 0, 43, 79),
  Color.fromARGB(255, 0, 66, 2),
  Color.fromARGB(255, 62, 4, 0),
  Color.fromARGB(255, 59, 36, 0),
  Color.fromARGB(255, 52, 0, 61),
  Color.fromARGB(255, 69, 0, 23),
];

List<String> graphtitle = [
  "De Dispersión",
  "De Volúmenes",
  "De Barras",
  "De Burbujas",
  "De Pasteles",
  "De Disperción (Comparación de Ejidos)",
];
final graphscrens = [
  const DispersionBar(),
  const VolumenGraph(),
  const BarGraph(),
  const BubbleGraph(),
  const PieGraph(),
  const CommonsLineGraph(),
];

class _TableGraphsState extends State<TableGraphs> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: DarkContainerWidget(
          data: DarkContainer(fill: GraphMenuWidget()),
        ),
      );
    });
  }
}
