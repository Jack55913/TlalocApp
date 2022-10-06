// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';
import 'package:tlaloc/src/ui/widgets/appbar/drawer.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/buttons/fab.dart';
import 'package:tlaloc/src/ui/widgets/view/dataview.dart';
import '../../widgets/appbar/profilepage.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({
    Key? key,
  }) : super(key: key);

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
                            // TODO: PONER UNA IMAGEN MÄS CHIDA
                            'assets/images/img-7.jpg',
                            fit: BoxFit.fitWidth,
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
                              Slidable(
                                  startActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                          backgroundColor: Colors.white,
                                          onPressed: (context) {
                                            Share.share(
                                                '¡Mira! el *${measurement.dateTime!.day}/${measurement.dateTime!.month}/${measurement.dateTime!.day} llovió ${measurement.precipitation} mm*. Ayúdame a medir, descargándo la app en tlaloc.web.app');
                                          },
                                          icon: Icons.share),
                                      SlidableAction(
                                          backgroundColor: Colors.blue,
                                          onPressed: (context) async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddScreen(
                                                    measurement: measurement),
                                              ),
                                            );
                                          },
                                          icon: Icons.edit),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.red,
                                        onPressed: (context) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                  '¿Estás seguro que quieres eliminar este registro?'),
                                              content: Text(
                                                  'No podrás recuperarlo una vez que lo elimines.'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Cancelar'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                                TextButton(
                                                  child: Text('Eliminar'),
                                                  onPressed: () async {
                                                    try {
                                                      final state =
                                                          Provider.of<AppState>(
                                                              context,
                                                              listen: false);
                                                      await state
                                                          .deleteMeasurement(
                                                              id: measurement
                                                                  .id);
                                                      Navigator.of(context)
                                                          .pop();
                                                    } catch (e) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: Text(
                                                              'Ocurrió un error al eliminar'),
                                                          content: Text('$e'),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            barrierDismissible: true,
                                          );
                                        },
                                        icon: Icons.delete,
                                      ),
                                    ],
                                  ),
                                  child:
                                      DataWidgetView(measurement: measurement)),
                            const Divider(
                              thickness: 1,
                            ),
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
