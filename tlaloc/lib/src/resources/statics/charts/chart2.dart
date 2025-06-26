import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:tlaloc/src/models/app_state.dart'; // tu ruta real

class LegendTitleLineal extends StatelessWidget {
  const LegendTitleLineal({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    // Lista de parajes a comparar
    final parajes = [
      'El Venturero',
      'El Jardín',
      'Cabaña',
      'Cruz de Atenco',
      'Canoas Altas',
      'Los Manantiales',
      'Tlaltlatlately',
      'Agua de Chiqueros',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dispersión de todos')),
      body: FutureBuilder<List<CartesianSeries<dynamic, dynamic>>>(
  future: _buildChartSeries(appState, parajes),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    return SfCartesianChart(
      title: ChartTitle(text: 'Real Precipitación por Paraje'),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'mm')),
      series: snapshot.data!,  // 👈 aquí ahora ya es del tipo correcto
    );
  },
),

    );
  }

  Future<List<LineSeries<ChartData, DateTime>>> _buildChartSeries(
      AppState appState, List<String> parajes) async {
    List<LineSeries<ChartData, DateTime>> seriesList = [];

    for (String paraje in parajes) {
      final snapshot = await appState.getRealMeasurementsStreamForParaje(paraje).first;
      final measurements = snapshot.docs.map((doc) {
        final data = doc.data();
        return ChartData(
          data['time'].toDate(),
          (data['precipitation'] as num).toDouble(),
        );
      }).toList();

      seriesList.add(
        LineSeries<ChartData, DateTime>(
          name: paraje,
          dataSource: measurements,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
      );
    }

    return seriesList;
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
