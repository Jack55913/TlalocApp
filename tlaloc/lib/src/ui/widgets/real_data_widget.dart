// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/resources/statics/modify_registration.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/view/dataview.dart';

class MyRealDataWidget extends StatelessWidget {
  final ScrollController scrollController;
  final Function(Measurement)? onMeasurementSelected;
  final bool isWideLayout;

  const MyRealDataWidget({
    super.key,
    required this.scrollController,
    this.onMeasurementSelected,
    this.isWideLayout = false,
  });

  String getTimeCategory(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'HOY';
    } else if (difference.inDays == 1) {
      return 'AYER';
    } else if (difference.inDays < 7) {
      return 'ESTA SEMANA';
    } else if (difference.inDays < 30) {
      return 'HACE UN MES';
    } else if (difference.inDays < 365) {
      return 'HACE UN AÑO';
    } else {
      return 'HACE MUCHO TIEMPO';
    }
  }

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
              final measurements = state.getMeasurementsFromDocs(
                measurementsSnapshot.docs,
              );

              if (measurements.isEmpty) {
                return const EmptyState('No hay registros aún.');
              }

              measurements.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));

              List<Widget> itemWidgets = [];
              String? lastCategory;

              for (var measurement in measurements) {
                final category = getTimeCategory(measurement.dateTime!);

                if (category != lastCategory) {
                  itemWidgets.add(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                  lastCategory = category;
                }

                itemWidgets.add(
                  Slidable(
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          onPressed: (context) {
                            Share.share(
                              '¡Mira! el *${measurement.dateTime!.day}/${measurement.dateTime!.month}/${measurement.dateTime!.year} llovió ${measurement.precipitation} mm*. Ayúdame a medir, descargando la app en tlaloc.web.app',
                            );
                          },
                          icon: Icons.share,
                        ),
                        if (state.canEditMeasurement(measurement.uploaderId))
                          SlidableAction(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            onPressed: (context) {
                              onMeasurementSelected?.call(measurement);
                            },
                            icon: Icons.edit,
                          ),
                      ],
                    ),
                    endActionPane:
                        state.canEditMeasurement(measurement.uploaderId)
                            ? ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            backgroundColor: AppColors.dark2,
                                            title: const Text(
                                              '¿Estás seguro que quieres eliminar este registro?',
                                            ),
                                            content: const Text(
                                              'No podrás recuperarlo una vez que lo elimines.',
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('Cancelar'),
                                                onPressed:
                                                    () =>
                                                        Navigator.of(
                                                          context,
                                                        ).pop(),
                                              ),
                                              TextButton(
                                                child: const Text('Eliminar'),
                                                onPressed: () async {
                                                  try {
                                                    final state =
                                                        Provider.of<AppState>(
                                                          context,
                                                          listen: false,
                                                        );
                                                    await state
                                                        .deleteMeasurement(
                                                          id: measurement.id,
                                                        );
                                                    await state
                                                        .deleteRealMeasurement(
                                                          id: measurement.id,
                                                        );
                                                    Navigator.of(context).pop();
                                                  } catch (e) {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (
                                                            context,
                                                          ) => AlertDialog(
                                                            title: const Text(
                                                              'Ocurrió un error al eliminar',
                                                            ),
                                                            content: Text('$e'),
                                                          ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                  icon: Icons.delete,
                                ),
                              ],
                            )
                            : null,
                    child: GestureDetector(
                      onTap: () {
                        onMeasurementSelected?.call(measurement);
                      },
                      child: DataWidgetView(
                        measurement: measurement,
                        onTap: () {
                          if (isWideLayout) {
                            onMeasurementSelected?.call(measurement);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => ModifyRegistration(
                                      measurement: measurement,
                                    ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              }

              return Scrollbar(
                controller: scrollController,
                thickness: 20.0,
                thumbVisibility: true,
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverList(delegate: SliverChildListDelegate(itemWidgets)),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
