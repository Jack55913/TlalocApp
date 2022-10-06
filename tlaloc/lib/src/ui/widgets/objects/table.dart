import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/objects/tablewiner.dart';

// TODO: Que aparezcan las mediciones de todos los ejidos en monitor ó visitante
// Ya que sólo aparecen las mediciones de una zona en específico

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
              fontFamily: 'Fredoka One',
            ),
          ),
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, state, _) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: state.getGeneralMeasurementsStream(),
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
                            TableWinerWidget(measurement: measurement),
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
      ),
    );
  }
}
