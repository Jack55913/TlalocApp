import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/excel.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/objects/tablewiner.dart';

class TableTlaloc extends StatelessWidget {
  const TableTlaloc({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: SelectableText(
            '📝 Mediciones Generales ',
            style: TextStyle(
              fontFamily: 'FredokaOne',
            ),
          ),
        ),
        actions: [
          IconButton(
                  icon: const Icon(Icons.file_download),
                  onPressed: () async {
                    try {
                      await appState.exportAllParajes(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Exportación completada',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al exportar: $e')),
                      );
                    }
                  },
                ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Consumer<AppState>(
                  builder: (context, state, _) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: state.getMeasurementsStreamForParaje('El Venturero'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements = state.getMeasurementsFromDocs(measurementsSnapshot.docs);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'El Venturero',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
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
                ),
                // ////////////////////////////////////////////////////////////
                Consumer<AppState>(
                  builder: (context, state, _) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                       stream: state.getMeasurementsStreamForParaje('El Jardín'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements = state.getMeasurementsFromDocs(measurementsSnapshot.docs);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'El Jardín',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              const Text(
                                'Cabaña',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              const Text(
                                'Cruz de Atenco',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              const Text(
                                'Canoas altas',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              const Text(
                                'Los Manantiales',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              const Text(
                                'Agua de Chiqueros',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              const Text(
                                'Tlaltlatlately',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
                                ),
                              ),
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              
                              for (var measurement in measurements)
                                TableWinerWidget(measurement: measurement),
                              const Divider(
                                thickness: 1,
                              ),
                              const Text(
                                'Camino a Trancas',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FredokaOne',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
