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
import 'package:tlaloc/src/ui/widgets/appbar/infobutton2.dart';
import 'package:tlaloc/src/ui/widgets/info/info_page.dart';

class DispersionBar extends StatefulWidget {
  const DispersionBar({super.key});

  @override
  State<DispersionBar> createState() => _DispersionBarState();
}

enum DateTimeMode { custom, week, month, year, always }

class _DispersionBarState extends State<DispersionBar> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;
  String? _currentParaje;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Dispersión',
          style: TextStyle(
            fontFamily: 'FredokaOne',
            fontSize: 24,
            letterSpacing: 2,
          ),
        ),
        actions: const [InfoButton2(), FluidDialogWidget()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDateControls(),
              const SizedBox(height: 20),
              _buildDatePickers(),
              const SizedBox(height: 20),
              _buildChartSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 4,
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
          const Text('Inicio: '),
          DatePickerButton(
            dateTime: initialDate,
            onDateChanged: (date) => _updateDates(date, isStart: true),
          ),
          const Expanded(child: SizedBox()),
          const Text('Fin: '),
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingIndicator();
            }
            if (snapshot.hasError) {
              return EmptyState('Error: ${snapshot.error}');
            }
            return _handleSnapshot(snapshot, state);
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

  Widget _handleSnapshot(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      AppState state) {
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return EmptyState('No hay datos en ${state.paraje}');
    }

    final measurements = state.getMeasurementsFromDocs(snapshot.data!.docs);
    final filtered = _filterMeasurements(measurements);

    return filtered.isEmpty
        ? const EmptyState('No hay datos en el rango seleccionado')
        : _buildChart(filtered, state.paraje);
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

  Widget _buildChart(List<Measurement> data, String paraje) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 350,
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
          ),
          title: ChartTitle(text: 'Dispersión en "$paraje"'),
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.days,
            dateFormat: DateFormat.MMMd('es'),
            title: AxisTitle(text: 'Fecha'),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Precipitación (mm)'),
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<Measurement, DateTime>>[
            ScatterSeries<Measurement, DateTime>(
              dataSource: data,
              xValueMapper: (m, _) => m.dateTime!,
              yValueMapper: (m, _) => m.precipitation ?? 0,
              name: paraje,
              markerSettings: const MarkerSettings(
                isVisible: true,
                height: 8,
                width: 8,
                shape: DataMarkerType.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'Cargando datos...',
            style: TextStyle(
              color: AppColors.blue1,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
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
          finalDate = monday.add(
              const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
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
