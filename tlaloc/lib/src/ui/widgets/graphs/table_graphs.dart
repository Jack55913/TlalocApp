// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tlaloc/src/resources/page/graphs/graph1.dart';
import 'package:tlaloc/src/resources/page/graphs/graph2.dart';
import 'package:tlaloc/src/resources/page/graphs/graph3.dart';
import 'package:tlaloc/src/resources/page/graphs/graph4.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/graphs/menugraphs.dart';
// import 'package:tlaloc/page/graphs/graph2.dart';

class TableGraphs extends StatefulWidget {
  const TableGraphs({Key? key}) : super(key: key);

  @override
  State<TableGraphs> createState() => _TableGraphsState();
}

List<String> graphimages = [
  "assets/images/g1.jpg",
  "assets/images/img-3.png",
  "assets/images/g1.jpg",
  "assets/images/img-6.png",
];
List<String> graphtitle = [
  "De Dispersión",
  "De Volúmenes",
  "De Barras",
  "De Burbujas",
];
final graphscrens = [
  const DispersionBar(),
  const VolumenGraph(),
  const BarGraph(),
  const BubbleGraph(),
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
