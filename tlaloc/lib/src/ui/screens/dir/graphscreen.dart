// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/ui/widgets/appbar/drawer.dart';
import 'package:tlaloc/src/ui/widgets/appbar/profilepage.dart';
import 'package:tlaloc/src/ui/widgets/buttons/fab.dart';
import 'package:tlaloc/src/ui/widgets/graphs/table_graphs.dart';

import '../../widgets/appbar/infobutton.dart';

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
          actions: const <Widget>[
            InfoButton(),
            ProfilePage(),
          ],
        ),
        drawer: DrawerApp(),
        body: Column(
          children: const [
            TableGraphs(),
            // TableGrids(),
          ],
        ),
        floatingActionButton: const Fab(),
      ),
    );
  }
}
