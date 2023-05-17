// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/view/dataview.dart';

class MyDataWidget extends StatelessWidget {
  const MyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
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
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        for (var measurement in measurements)
                          Slidable(
                              startActionPane: ActionPane(
                                motion: const StretchMotion(),
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
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.red,
                                    onPressed: (context) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              '¿Estás seguro que quieres eliminar este registro?'),
                                          content: const Text(
                                              'No podrás recuperarlo una vez que lo elimines.'),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancelar'),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                            TextButton(
                                              child: const Text('Eliminar'),
                                              onPressed: () async {
                                                try {
                                                  final state =
                                                      Provider.of<AppState>(
                                                          context,
                                                          listen: false);
                                                  await state.deleteMeasurement(
                                                      id: measurement.id);
                                                  await state
                                                      .deleteRealMeasurement(
                                                          id: measurement.id);
                                                  // TODO: PUNTO 1.1 DEL CONTRATO. Cuando eliminamos una medición, también eliminarlo de los reales
                                                  Navigator.of(context).pop();
                                                } catch (e) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
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
                              child: DataWidgetView(measurement: measurement)),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}

class MyRealDataWidget extends StatelessWidget {
  const MyRealDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: state.getRealMeasurementsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return EmptyState('Error ${snapshot.error}');
            } else if (snapshot.hasData) {
              final measurementsSnapshot = snapshot.data!;
              final measurements =
                  state.getRealMeasurementsFromSnapshot(measurementsSnapshot);
              return CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        for (var measurement in measurements)
                          Slidable(
                              startActionPane: ActionPane(
                                motion: const StretchMotion(),
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
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.red,
                                    onPressed: (context) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              '¿Estás seguro que quieres eliminar este registro?'),
                                          content: const Text(
                                              'No podrás recuperarlo una vez que lo elimines.'),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancelar'),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                            TextButton(
                                              child: const Text('Eliminar'),
                                              onPressed: () async {
                                                try {
                                                  final state =
                                                      Provider.of<AppState>(
                                                          context,
                                                          listen: false);
                                                  await state.deleteMeasurement(
                                                      id: measurement.id);
                                                  await state
                                                      .deleteRealMeasurement(
                                                          id: measurement.id);
                                                  Navigator.of(context).pop();
                                                } catch (e) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
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
                              child: DataWidgetView(measurement: measurement)
                              ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}
