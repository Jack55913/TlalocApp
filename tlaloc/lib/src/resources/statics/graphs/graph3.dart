import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/datepicker.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';

class VolumenGraph extends StatefulWidget {
  const VolumenGraph({super.key});

  @override
  State<VolumenGraph> createState() => _VolumenGraphState();
}

enum DateTimeMode { custom, week, month, year, always }

class _VolumenGraphState extends State<VolumenGraph> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;
  String? _currentParaje;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Gráfica de Volumen',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            _buildDateControls(),
            const SizedBox(height: 12),
            _buildDatePickers(),
            Expanded(child: _buildChartSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildDateControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 6,
        children: [
          _buildChoiceChip('Esta semana', DateTimeMode.week),
          _buildChoiceChip('Este mes', DateTimeMode.month),
          _buildChoiceChip('Este año', DateTimeMode.year),
          _buildChoiceChip('Siempre', DateTimeMode.always),
        ],
      ),
    );
  }

  Widget _buildDatePickers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Text('Inicio:'),
          DatePickerButton(
            dateTime: initialDate,
            onDateChanged: (date) => _updateDates(date, isStart: true),
          ),
          const Spacer(),
          const Text('Fin:'),
          DatePickerButton(
            dateTime: finalDate,
            onDateChanged: (date) => _updateDates(date, isStart: false),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Consumer<AppState>(
      builder: (context, state, _) {
        _handleParajeChange(state);
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          key: Key('${state.rol}-${state.paraje}'),
          stream: state.getMeasurementsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return EmptyState('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return EmptyState('No hay datos disponibles');
            }

            final measurements =
                state.getMeasurementsFromDocs(snapshot.data!.docs);
            final filteredMeasurements = _filterMeasurements(measurements);

            if (filteredMeasurements.isEmpty) {
              return const EmptyState('No hay datos en el rango seleccionado');
            }

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SfCartesianChart(
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enablePanning: true,
                ),
                title: ChartTitle(text: 'Volumen en "${state.paraje}"'),
                tooltipBehavior: TooltipBehavior(enable: true),
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  dateFormat: DateFormat.MMMd('es'),
                  title: AxisTitle(text: 'Fecha'),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Precipitación (mm)'),
                ),
                series: <CartesianSeries<Measurement, DateTime>>[
                  AreaSeries<Measurement, DateTime>(
                    xValueMapper: (m, _) => m.dateTime,
                    yValueMapper: (m, _) => m.precipitation,
                    dataSource: filteredMeasurements,
                    name: state.paraje,
                    color: AppColors.blue1.withOpacity(0.6),
                    borderColor: AppColors.blue1,
                    borderWidth: 2,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _handleParajeChange(AppState state) {
    if (_currentParaje != state.paraje) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => _currentParaje = state.paraje);
      });
    }
  }

  List<Measurement> _filterMeasurements(List<Measurement> measurements) {
    return measurements
        .where((m) =>
            m.dateTime != null &&
            m.dateTime!.isAfter(initialDate) &&
            m.dateTime!.isBefore(finalDate))
        .toList()
      ..sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
  }

  void _updateDates(DateTime date, {required bool isStart}) {
    setState(() {
      mode = DateTimeMode.custom;
      if (isStart) {
        initialDate = date;
      } else {
        finalDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
      }
    });
  }

  Widget _buildChoiceChip(String label, DateTimeMode value) {
    return ChoiceChip(
      selectedColor: AppColors.blue1,
      label: Text(label),
      selected: mode == value,
      onSelected: (val) => val ? _handleTimeModeChange(value) : null,
    );
  }

  void _handleTimeModeChange(DateTimeMode value) {
    final now = DateTime.now();
    setState(() {
      mode = value;
      switch (value) {
        case DateTimeMode.week:
          final monday = now.subtract(Duration(days: now.weekday - 1));
          initialDate = monday;
          finalDate =
              monday.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
          break;
        case DateTimeMode.month:
          initialDate = DateTime(now.year, now.month, 1);
          finalDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
          break;
        case DateTimeMode.year:
          initialDate = DateTime(now.year, 1, 1);
          finalDate = DateTime(now.year, 12, 31, 23, 59, 59);
          break;
        case DateTimeMode.always:
          initialDate = dateLongAgo;
          finalDate = dateInALongTime;
          break;
        case DateTimeMode.custom:
          break;
      }
    });
  }
}
