import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';

class TodayWeatherStyleCard extends StatelessWidget {
  const TodayWeatherStyleCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final paraje = appState.paraje;

    return FutureBuilder<List<Measurement>>(
      future: appState.getMeasurements(),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final todayStr = DateFormat('yyyy-MM-dd').format(now);

        Measurement? todayMeasurement;
        if (snapshot.hasData) {
          todayMeasurement = snapshot.data!.firstWhere(
            (m) => DateFormat('yyyy-MM-dd').format(m.dateTime!) == todayStr,
            orElse:
                () =>
                    Measurement(id: 'none', precipitation: null, dateTime: now),
          );
        }

        final bool hasData = todayMeasurement?.precipitation != null;
        final bool rained = (todayMeasurement?.precipitation ?? 0) > 0;

        return GlassContainer(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ICONO + UBICACIÓN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.location_on, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    'Monte Tláloc',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // PARAJE ACTUAL
              Text(
                paraje,
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
              const SizedBox(height: 5),
              // PRECIPITACIÓN DEL DÍA
              Text(
                hasData
                    ? '${todayMeasurement!.precipitation!.toStringAsFixed(0)} mm'
                    : '-- mm',
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              // ESTADO DEL DÍA
              Text(
                hasData
                    ? (rained ? 'LLUVIOSO' : 'SIN LLUVIA')
                    : 'SIN MEDICIÓN, IR A MEDIR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      hasData
                          ? (rained ? Colors.blueAccent : Colors.grey)
                          : Colors.redAccent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
