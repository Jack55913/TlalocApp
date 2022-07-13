// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/page/graphs/graph1.dart';
import 'package:tlaloc/page/graphs/graph2.dart';

class TableGraphs extends StatefulWidget {
  const TableGraphs({Key? key}) : super(key: key);

  @override
  State<TableGraphs> createState() => _TableGraphsState();
}

List<String> graphimages = [
  "assets/images/img-2.png",
  "assets/images/img-3.png",
];
List<String> graphtitle = [
  "De Dispersión",
  "De Barras",
];
final graphscrens = [
  const DispersionBar(),
  const BarGraph(),
];

class _TableGraphsState extends State<TableGraphs> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                  itemBuilder: (BuildContext, index) => Card(
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
                    ),
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
    });
  }
}
