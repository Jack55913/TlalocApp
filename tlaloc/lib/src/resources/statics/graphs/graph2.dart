import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/datepicker.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton2.dart';
import 'package:tlaloc/src/ui/widgets/info/info_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:universal_html/html.dart' as html;

class BarGraph extends StatefulWidget {
  const BarGraph({super.key});

  @override
  State<BarGraph> createState() => _BarGraphState();
}

enum DateTimeMode { custom, week, month, year, always }

enum DataMode { accumulated, real }

class _BarGraphState extends State<BarGraph> {
  DateTime initialDate = dateLongAgo;
  DateTime finalDate = dateInALongTime;
  DateTimeMode mode = DateTimeMode.always;
  String? _currentParaje;
  DataMode dataMode = DataMode.accumulated;
  final GlobalKey chartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/tlaloc_logo.png', height: 32),
            const SizedBox(width: 8),
            AutoSizeText(
              dataMode == DataMode.real
                  ? 'Volumen'
                  : 'Acumulados',
              style: const TextStyle(
                fontFamily: 'FredokaOne',
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _exportToPdf(context),
            tooltip: 'Exportar a PDF',
          ),
          InfoButton2(),
          FluidDialogWidget(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                dataMode == DataMode.real
                    ? 'Mostrar datos reales'
                    : 'Mostrar acumulados',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              value: dataMode == DataMode.real,
              onChanged:
                  (val) => setState(
                    () => dataMode = val ? DataMode.real : DataMode.accumulated,
                  ),
            ),
            const SizedBox(height: 10),
            _buildDateControls(),
            const SizedBox(height: 20),
            _buildDatePickers(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildChartSection(isReal: dataMode == DataMode.real),
            ),
          ],
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

  Widget _buildChartSection({bool isReal = false}) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        _handleParajeChange(state);
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          key: Key('${state.rol}-${state.paraje}'),
          stream:
              isReal
                  ? state.getRealMeasurementsStream()
                  : state.getMeasurementsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingIndicator();
            }
            if (snapshot.hasError) {
              return EmptyState('Error: ${snapshot.error}');
            }
            return _handleSnapshot(snapshot, state, isReal: isReal);
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
    AppState state, {
    bool isReal = false,
  }) {
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return EmptyState('No hay datos en ${state.paraje}');
    }

    final measurements = state.getMeasurementsFromDocs(snapshot.data!.docs);
    final filteredMeasurements = _filterMeasurements(
      isReal ? _filterOnlyReal(measurements) : measurements,
    );

    return filteredMeasurements.isEmpty
        ? const EmptyState('No hay datos en el rango seleccionado')
        : _buildChart(filteredMeasurements);
  }

  List<Measurement> _filterOnlyReal(List<Measurement> realValue) {
    return realValue
        .where(
          (m) =>
              m.dateTime != null &&
              m.dateTime!.isAfter(initialDate) &&
              m.dateTime!.isBefore(finalDate),
        )
        .toList()
      ..sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
  }

  List<Measurement> _filterMeasurements(List<Measurement> measurements) {
    return measurements
        .where(
          (m) =>
              m.dateTime != null &&
              m.dateTime!.isAfter(initialDate) &&
              m.dateTime!.isBefore(finalDate),
        )
        .toList()
      ..sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
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
            style: TextStyle(color: AppColors.blue1, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<Measurement> measurements) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final surfaceVariant = theme.colorScheme.surfaceContainerHighest;
    final onSurface = theme.colorScheme.onSurface;

    // Definir ancho total dinámico
    final chartWidth =
        (measurements.length * 40).toDouble().clamp(300, 2000).toDouble();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: chartWidth,
            child: RepaintBoundary(
              key: chartKey,
              child: BarChart(
                BarChartData(
                  groupsSpace: 16,
                  alignment: BarChartAlignment.spaceBetween,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      // tooltipBgColor: primaryColor.withOpacity(0.9),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final date = DateFormat(
                          'dd/MM/yy',
                        ).format(measurements[groupIndex].dateTime!);
                        final value = rod.toY.toStringAsFixed(1);
                        return BarTooltipItem(
                          '$date\n$value mm',
                          TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      axisNameWidget: Text(
                        'Precipitación (mm)',
                        style: TextStyle(
                          color: onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        interval: _calculateYInterval(measurements),
                        getTitlesWidget:
                            (value, meta) => Text(
                              '${value.toInt()}',
                              style: TextStyle(color: onSurface, fontSize: 12),
                            ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Fecha',
                          style: TextStyle(
                            color: onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          const maxLabels = 10;
                          final total = measurements.length;
                          if (total <= maxLabels ||
                              index % (total ~/ maxLabels) == 0) {
                            if (index >= 0 && index < total) {
                              return _buildDateLabel(
                                measurements[index].dateTime!,
                              );
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(width: 1, color: Colors.grey),
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: _calculateYInterval(measurements),
                    getDrawingHorizontalLine:
                        (value) =>
                            FlLine(color: surfaceVariant, strokeWidth: 1),
                  ),
                  barGroups:
                      measurements.asMap().entries.map((entry) {
                        final index = entry.key;
                        final m = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: (m.precipitation ?? 0).toDouble(),
                              color: primaryColor,
                              width: 5,
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.9),
                                  primaryColor.withOpacity(0.5),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: (m.precipitation ?? 0) * 1.1,
                                color: surfaceVariant.withOpacity(0.3),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                  minY: 0,
                  maxY: _calculateMaxY(measurements),
                ),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuart,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateMaxY(List<Measurement> measurements) {
    if (measurements.isEmpty) return 10;
    final max = measurements
        .map((m) => m.precipitation ?? 0)
        .reduce((a, b) => a > b ? a : b);
    return (max * 1.2).toDouble();
  }

  double _calculateYInterval(List<Measurement> measurements) {
    if (measurements.isEmpty) return 10; // Manejo de lista vacía

    final maxPrecip = measurements
        .map((m) => m.precipitation?.toDouble() ?? 0.0)
        .reduce((a, b) => a > b ? a : b); // Versión más eficiente

    if (maxPrecip > 50) return 20;
    if (maxPrecip > 20) return 10;
    return 5;
  }

  Widget _buildDateLabel(DateTime date) {
    return Transform.rotate(
      angle: -0.4,
      child: Text(
        DateFormat('dd/MM').format(date),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  void _updateDates(DateTime date, {required bool isStart}) {
    setState(() {
      mode = DateTimeMode.custom;
      if (isStart) {
        initialDate = date;
      } else {
        finalDate = DateTime(
          date.year,
          date.month,
          date.day,
        ).add(const Duration(days: 1)).subtract(const Duration(seconds: 1));
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
            const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
          );
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

  Future<void> _exportToPdf(BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    final measurements = await _getCurrentMeasurements(appState);

    if (measurements.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay datos para exportar')),
      );
      return;
    }

    final pdf = pw.Document();
    final theme = Theme.of(context);
    final title =
        dataMode == DataMode.real
            ? 'Datos Reales de Precipitación'
            : 'Volúmenes Acumulados de Precipitación';
    final dateRange =
        '${DateFormat('dd/MM/yyyy').format(initialDate)} - ${DateFormat('dd/MM/yyyy').format(finalDate)}';
    final paraje = appState.paraje;

    final chartImage = await _generateChartImage(measurements, theme);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(title, style: pw.TextStyle(fontSize: 20)),
              ),
              pw.Text('Paraje: $paraje'),
              pw.Text('Rango de fechas: $dateRange'),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Container(
                  height: 300,
                  child: pw.FittedBox(child: pw.Image(chartImage)),
                ),
              ),
              pw.SizedBox(height: 20),
              _buildDataTable(measurements),
            ],
          );
        },
      ),
    );

    // Guardar o mostrar el PDF según la plataforma
    final bytes = await pdf.save();
    await _saveOrPrintPdf(context, bytes, title);
  }

  Future<void> _saveOrPrintPdf(
    BuildContext context,
    Uint8List bytes,
    String title,
  ) async {
    if (kIsWeb) {
      // TODO: REACTIVAR CUANDO SEA EN WEB
      // Para web: descarga directa
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor =
          html.AnchorElement(href: url)
            ..setAttribute('download', '$title.pdf')
            ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      // Para móvil: mostrar diálogo de impresión/guardado
      try {
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => bytes,
        );
      } catch (e) {
        // Si falla la impresión, guardar el archivo
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$title.pdf');
        await file.writeAsBytes(bytes);

        // Opcional: usar file_saver para mejor experiencia de usuario
        try {
          await FileSaver.instance.saveFile(
            name: title,
            bytes: bytes,
            mimeType: MimeType.pdf,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF guardado en: ${file.path}')),
          );
        }
      }
    }
  }

  Future<List<Measurement>> _getCurrentMeasurements(AppState state) async {
    final snapshot =
        await (dataMode == DataMode.real
            ? state.getRealMeasurementsStream().first
            : state.getMeasurementsStream().first);

    final measurements = state.getMeasurementsFromDocs(snapshot.docs);
    return _filterMeasurements(measurements);
  }

  Future<pw.MemoryImage> _generateChartImage(
    List<Measurement> measurements,
    ThemeData theme,
  ) async {
    final boundary =
        chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    return pw.MemoryImage(bytes);
  }

  pw.Widget _buildDataTable(List<Measurement> measurements) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Fecha',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Precipitación (mm)',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ],
        ),
        ...measurements.map(
          (m) => pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(
                  DateFormat('dd/MM/yyyy').format(m.dateTime!),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(
                  (m.precipitation ?? 0).toStringAsFixed(1),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
