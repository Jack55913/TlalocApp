import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';

class DayBarChart extends StatelessWidget {
  final DateTime day;

  const DayBarChart({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(milliseconds: 1));

    return Consumer<AppState>(
      builder: (context, state, _) {
        return StreamBuilder(
          stream: state.getRealMeasurementsStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final measurements =
                state
                    .getMeasurementsFromDocs(snapshot.data!.docs)
                    .where(
                      (m) =>
                          m.dateTime != null &&
                          m.dateTime!.isAfter(startOfDay) &&
                          m.dateTime!.isBefore(endOfDay),
                    )
                    .toList()
                  ..sort((a, b) => a.dateTime!.compareTo(b.dateTime!));

            if (measurements.isEmpty) {
              return const Center(child: Text('No hay datos para este día'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    barGroups:
                        measurements.asMap().entries.map((entry) {
                          final index = entry.key;
                          final m = entry.value;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: (m.precipitation ?? 0).toDouble(),
                                color: Colors.blue,
                                width: 10,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          );
                        }).toList(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            final index = value.toInt();
                            if (index >= 0 && index < measurements.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  DateFormat(
                                    'HH:mm',
                                  ).format(measurements[index].dateTime!),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    // color: Colors.black54,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 30, // Espacio para las etiquetas
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                // color: Colors.black54,
                              ),
                            );
                          },
                          reservedSize: 30, // Espacio para las etiquetas
                          interval: 50, // Mostrar marcas cada 50 unidades
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 50,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    minY: 0,
                    maxY: 300, // Establecer el máximo del eje Y a 300
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
