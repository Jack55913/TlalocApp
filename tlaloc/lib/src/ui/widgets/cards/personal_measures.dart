import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MeasurementCounter extends StatelessWidget {
  final Stream<QuerySnapshot> stream;
  final bool Function(Measurement) filter;

  const MeasurementCounter({
    required this.stream,
    required this.filter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) return _buildError();
        if (!snapshot.hasData) return _buildLoader();

        final count =
            snapshot.data!.docs
                .map(
                  (doc) => Measurement.fromJson(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ),
                )
                .where(filter)
                .length;

        return _buildCount(context, count.toDouble());
      },
    );
  }

  Widget _buildCount(BuildContext context, count) => Text(
    '$count',
    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
      color: AppColors.blue1,
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _buildLoader() => const SizedBox(
    width: 20,
    height: 20,
    child: CircularProgressIndicator(color: AppColors.blue1, strokeWidth: 2),
  );

  Widget _buildError() =>
      const Text('---', style: TextStyle(color: AppColors.blue1));
}

class PersonalMeasures extends StatelessWidget {
  const PersonalMeasures({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final appState = Provider.of<AppState>(context);

    return Column(
      children: [
        _buildCounterCard(
          context,
          icon: Icons.location_on,
          label: 'Tus mediciones completadas aquí',
          counter: MeasurementCounter(
            stream: appState.getMeasurementsStream(),
            filter:
                (measurement) =>
                    measurement.uploader == currentUser?.displayName,
          ),
        ),

        _buildCounterCard(
          context,
          icon: Icons.assignment_ind,
          label: 'Tus mediciones totales',
          counter: MeasurementCounter(
            stream: appState.getAllUserMeasurementsStream(),
            filter: (measurement) => measurement.uploaderId == currentUser?.uid,
          ),
        ),
      ],
    );
  }

  Widget _buildCounterCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget counter,
  }) {
    return Card(
      // color: AppColors.dark2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.blue1,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AutoSizeText(
                label,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  // color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 16),
            counter,
          ],
        ),
      ),
    );
  }
}

class GeneralMeasures extends StatelessWidget {
  const GeneralMeasures({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(
      children: [
        _buildCounterCard(
          context,
          icon: Icons.people_alt,
          label: 'Mediciones del paraje',
          counter: MeasurementCounter(
            stream: appState.getMeasurementsStream(),
            filter: (_) => true,
          ),
        ),
        _buildCounterCard(
          context,
          icon: Icons.public,
          label: 'Mediciones en el Monte',
          counter: MeasurementCounter(
            stream: appState.getAllMeasurementsStream(),
            filter: (_) => true,
          ),
        ),
      ],
    );
  }

  Widget _buildCounterCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget counter,
  }) {
    return Card(
      // color: AppColors.dark2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.blue1,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AutoSizeText(
                label,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  // color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 16),
            counter,
          ],
        ),
      ),
    );
  }
}
