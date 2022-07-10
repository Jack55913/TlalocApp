// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/page/graphs/graph1.dart';
import 'package:tlaloc/page/graphs/graph2.dart';
import 'package:tlaloc/page/home.dart';
import 'package:tlaloc/screens/home.dart';
import 'package:tlaloc/widgets/empty_state.dart';
import '../models/app_state.dart';

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({Key? key}) : super(key: key);

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  List<String> graphimages = [
    "assets/images/img-2.png",
    "assets/images/img-1.png",
  ];
  List<String> chartimages = [
    "assets/images/img-3.png",
    "assets/images/img-4.png",
  ];
  List<String> graphtitle = [
    "De Dispersión",
    "De Barras",
  ];
  List<String> charttitle = [
    "De Tortas",
    "De Pasteles",
  ];
  final graphscrens = [
    DispersionBar(),
    BarGraph(),
  ];
  final chartscrens = [
    DispersionBar(),
    BarGraph(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Gráficas y estadísticas',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          actions: <Widget>[
            InfoButton(),
            ProfilePage(),
          ],
        ),
        body: Column(
          children: [
            Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.dark2,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text('Gráficas',
                          style: TextStyle(
                            fontFamily: 'FredokaOne',
                            fontSize: 24,
                            letterSpacing: 2,
                            color: AppColors.green1,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (BuildContext, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(graphimages[index]),
                                ),
                                title: Text(graphtitle[index]),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => graphscrens[index],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          itemCount: graphimages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.dark2,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text('Tablas',
                          style: TextStyle(
                            fontFamily: 'FredokaOne',
                            fontSize: 24,
                            letterSpacing: 2,
                            color: AppColors.green1,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (BuildContext, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(chartimages[index]),
                                ),
                                title: Text(graphtitle[index]),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => chartscrens[index],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          itemCount: chartimages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: const Fab(),
      ),
    );
  }
}
