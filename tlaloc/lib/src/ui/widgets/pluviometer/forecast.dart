import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';

class WeekRainMarker extends StatefulWidget {
  const WeekRainMarker({super.key});

  @override
  State<WeekRainMarker> createState() => _WeekRainMarkerState();
}

class _WeekRainMarkerState extends State<WeekRainMarker> {
  late Future<List<Measurement>> _measurementsFuture;
  final _dateFormat = DateFormat('yyyy-MM-dd');
  final _dayNameFormat = DateFormat('EEEE', 'es_MX');
  final _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _measurementsFuture = appState.getMeasurements();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Measurement>>(
      future: _measurementsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildLoadingCard();
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyCard();
        }

        return _buildContentCard(snapshot.data!);
      },
    );
  }

  Widget _buildLoadingCard() {
    return const Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('No hay datos de precipitación disponibles')),
      ),
    );
  }

  Widget _buildContentCard(List<Measurement> measurements) {
    final measurementMap = {
      for (var m in measurements)
        if (m.dateTime != null) _dateFormat.format(m.dateTime!): m
    };

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          const _Header(),
          const Divider(thickness: 2),
          ..._buildDayTiles(measurementMap),
        ],
      ),
    );
  }

  List<Widget> _buildDayTiles(Map<String, Measurement> measurementMap) {
    return List.generate(7, (i) {
      final day = _now.subtract(Duration(days: i));
      final formattedDay = _dateFormat.format(day);
      
      final measurement = measurementMap[formattedDay] ?? 
          Measurement(id: 'none', dateTime: day, precipitation: null);

      return _DayTile(
        day: day,
        measurement: measurement,
        dayNameFormat: _dayNameFormat,
        isToday: i == 0,
        isYesterday: i == 1,
      );
    });
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.calendar_month, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            'Marcador Semanal de Lluvia',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _DayTile extends StatelessWidget {
  final DateTime day;
  final Measurement measurement;
  final DateFormat dayNameFormat;
  final bool isToday;
  final bool isYesterday;

  const _DayTile({
    required this.day,
    required this.measurement,
    required this.dayNameFormat,
    required this.isToday,
    required this.isYesterday,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildWeatherIcon(),
      title: Text(_getDayLabel()),
      trailing: Text(_getValueText()),
    );
  }

  Widget _buildWeatherIcon() {
    return (measurement.precipitation ?? 0) > 0
        ? const Icon(Icons.cloud, color: Colors.blue)
        : const Icon(Icons.wb_sunny, color: Colors.orange);
  }

  String _getDayLabel() {
    return isToday
        ? 'HOY'
        : isYesterday
            ? 'AYER'
            : dayNameFormat.format(day).toUpperCase();
  }

  String _getValueText() {
    return measurement.precipitation != null
        ? '${measurement.precipitation!.toStringAsFixed(1)} mm'
        : 'SIN M.';
  }
}