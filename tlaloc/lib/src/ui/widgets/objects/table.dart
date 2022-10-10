import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/objects/tablewiner.dart';

class TableTlaloc extends StatelessWidget {
  const TableTlaloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Consumer<AppState>(
                  builder: (context, state, _) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: state.getElVentureroMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
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
                      stream: state.getElJardinMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
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
                      stream: state.getCabanaMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                      stream: state.getCruzdeAtencoMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                      stream: state.getCanoasaltasMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                      stream: state.getLosManantialesMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                Consumer<AppState>(
                  builder: (context, state, _) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: state.getAguadeChiquerosMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                      stream: state.getTlaltlatlatelyMeasurementsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState('Error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final measurementsSnapshot = snapshot.data!;
                          final measurements =
                              state.getMeasurementsFromSnapshot(
                                  measurementsSnapshot);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
