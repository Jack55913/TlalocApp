import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tlaloc/src/models/custompathpainter.dart';

num _level = 80;

class TlalocPluviometer extends StatefulWidget {
  const TlalocPluviometer({super.key});

  @override
  State<TlalocPluviometer> createState() => _TlalocPluviometerState();
}

class _TlalocPluviometerState extends State<TlalocPluviometer> {
  _TlalocPluviometerState();

  final num _minimumLevel = 0;
  final num _maximumLevel = 300;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: _buildWaterIndicator(context),
      ),
    );
  }

  /// Returns the water indicator.
  Widget _buildWaterIndicator(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;

    return Padding(
        padding: const EdgeInsets.all(10),
        child: SfLinearGauge(
          minimum: _minimumLevel.toDouble(),
          maximum: _maximumLevel.toDouble(),
          orientation: LinearGaugeOrientation.vertical,
          interval: 10,
          axisTrackStyle: const LinearAxisTrackStyle(
            thickness: 2,
          ),
          markerPointers: <LinearMarkerPointer>[
            LinearWidgetPointer(
              value: _level.toDouble(),
              enableAnimation: false,
              onChanged: (dynamic value) {
                setState(() {
                  _level = value as num;
                });
              },
              child: Material(
                elevation: 4.0,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.blue,
                child: Ink(
                  width: 32.0,
                  height: 32.0,
                  child: InkWell(
                    splashColor: Colors.grey,
                    hoverColor: Colors.blueAccent,
                    onTap: () {},
                    child: Center(
                      child: _level == _minimumLevel
                          ? const Icon(Icons.keyboard_arrow_up_outlined,
                              color: Colors.white, size: 18.0)
                          : _level == _maximumLevel
                              ? const Icon(Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white, size: 18.0)
                              : const RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(Icons.code_outlined,
                                      color: Colors.white, size: 18.0)),
                    ),
                  ),
                ),
              ),
            ),
            LinearWidgetPointer(
              value: _level.toDouble(),
              enableAnimation: false,
              markerAlignment: LinearMarkerAlignment.end,
              offset: 67,
              position: LinearElementPosition.outside,
              child: SizedBox(
                width: 50,
                height: 20,
                child: Center(
                  child: Text(
                    '${_level.toStringAsFixed(0)} mm',
                    style: TextStyle(
                        color: brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
          barPointers: <LinearBarPointer>[
            LinearBarPointer(
              value: _maximumLevel.toDouble(),
              enableAnimation: false,
              thickness: 150,
              offset: 18,
              position: LinearElementPosition.outside,
              color: Colors.transparent,
              child: CustomPaint(
                  painter: CustomPathPainter(
                      color: Colors.blue,
                      waterLevel: _level.toDouble(),
                      maximumPoint: _maximumLevel.toDouble())),
            )
          ],
        ));
  }
}
