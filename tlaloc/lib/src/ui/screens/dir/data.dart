// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/ui/widgets/appbar/drawer.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/buttons/fab.dart';
import 'package:tlaloc/src/ui/widgets/view/dataview.dart';
import '../../widgets/appbar/profilepage.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerApp(),
        floatingActionButton: Fab(),
        body: Consumer<AppState>(
          builder: (context, state, _) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: state.getMeasurementsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return EmptyState('Error ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final measurementsSnapshot = snapshot.data!;
                  final measurements =
                      state.getMeasurementsFromSnapshot(measurementsSnapshot);
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        snap: false,
                        expandedHeight: 150.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text('Bitácora',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'FredokaOne',
                                fontSize: 24,
                                letterSpacing: 2,
                              )),
                          background: Image.asset(
                            'assets/images/img-7.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        actions: <Widget>[
                          InfoButton(),
                          ProfilePage(),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            for (var measurement in measurements)
                              DataWidgetView(measurement: measurement),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}