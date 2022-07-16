// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/page/drawer.dart';
import 'package:tlaloc/page/home.dart';
import 'package:tlaloc/screens/home/kernel.dart';
import 'package:tlaloc/widgets/buttons/fab.dart';
import 'package:tlaloc/widgets/graphs/table_graphs.dart';
import 'package:tlaloc/widgets/graphs/table_grids.dart';

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({Key? key}) : super(key: key);

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            'Estadísticas',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrawerApp()),
              );
            },
          ),
          actions: <Widget>[
            InfoButton(),
            ProfilePage(),
          ],
        ),
        body: Column(
          children: const [
            TableGraphs(),
            TableGrids(),
          ],
        ),
        floatingActionButton: const Fab(),
      ),
    );
  }
}
