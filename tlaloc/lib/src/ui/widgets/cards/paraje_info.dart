import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';

class ParajeInfoSection extends StatefulWidget {
  const ParajeInfoSection({super.key});

  @override
  State<ParajeInfoSection> createState() => _ParajeInfoSectionState();
}

class _ParajeInfoSectionState extends State<ParajeInfoSection> {
  late Future<Map<String, dynamic>> _parajeDataFuture;

  @override
  void initState() {
    super.initState();
    final state = Provider.of<AppState>(context, listen: false);
    _parajeDataFuture = state.getCurrentParajeData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _parajeDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text(
            'Error al cargar la información',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.red),
          );
        }

        final text =
            snapshot.data?['descripcion'] ?? 'No hay descripción disponible...';

        return Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                // color: Colors.white70,
                height: 1.4,
              ),
        );
      },
    );
  }
}
