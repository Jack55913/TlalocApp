import 'package:flutter/material.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/graphs/menugraphs.dart';

class TableGraphs extends StatefulWidget {
  const TableGraphs({super.key});

  @override
  State<TableGraphs> createState() => _TableGraphsState();
}


class _TableGraphsState extends State<TableGraphs> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassContainer(
          child: const GraphMenuWidget()),
      
      );
    });
  }
}
