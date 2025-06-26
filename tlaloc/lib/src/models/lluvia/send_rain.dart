import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tlaloc/src/models/custompathpainter.dart';

class RainInputWidget extends StatefulWidget {
  final num precipitation;
  final ValueChanged<num> onChanged;

  const RainInputWidget({
    super.key,
    required this.precipitation,
    required this.onChanged,
  });

  @override
  State<RainInputWidget> createState() => _RainInputWidgetState();
}

class _RainInputWidgetState extends State<RainInputWidget> {
  static const num _minimumLevel = 0;
  static const num _maximumLevel = 300;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.precipitation.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue(num value) {
    value = value.clamp(_minimumLevel, _maximumLevel);
    _controller.text = value.toStringAsFixed(0);
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      children: [
        TextFormField(
          controller: _controller,
          cursorColor: Colors.indigo,
          style: const TextStyle(fontSize: 24, fontFamily: 'FredokaOne'),
          decoration: InputDecoration(
            icon: CircleAvatar(
              backgroundColor: Colors.blue[300],
              child: Icon(Icons.water_drop, color: Colors.blue[900]),
            ),
            helperText: '3. Ingresar medición de lluvia (0-300 mm)',
            hintText: '0',
          ),
          onChanged: (value) {
            final parsed = num.tryParse(value);
            if (parsed != null) {
              _updateValue(parsed);
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}$')),
            LengthLimitingTextInputFormatter(3),
          ],
          validator:
              RangeValidator(
                min: _minimumLevel,
                max: _maximumLevel,
                errorText: 'Debe ser entre 0 y 300 mm',
              ).call,
        ),
        SizedBox(
          height: 250,
          child: SfLinearGauge(
            minimum: _minimumLevel.toDouble(),
            maximum: _maximumLevel.toDouble(),
            orientation: LinearGaugeOrientation.vertical,
            interval: 50,
            axisTrackStyle: const LinearAxisTrackStyle(thickness: 3),
            markerPointers: <LinearMarkerPointer>[
              LinearWidgetPointer(
                value: widget.precipitation.toDouble(),
                enableAnimation: true,
                onChanged: (value) => _updateValue(value.round()),

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
                      // onTap: () {},
                      child: Center(
                        child:
                            widget.precipitation == _minimumLevel
                                ? const Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  color: Colors.white,
                                  size: 18.0,
                                )
                                : widget.precipitation == _maximumLevel
                                ? const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                  size: 18.0,
                                )
                                : const RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.code_outlined,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ),
              ),
              LinearWidgetPointer(
                value: widget.precipitation.toDouble(),
                enableAnimation: true,
                markerAlignment: LinearMarkerAlignment.end,
                offset: 67,
                position: LinearElementPosition.outside,
                child: SizedBox(
                  width: 60,
                  height: 20,
                  child: Center(
                    child: Text(
                      '${widget.precipitation.toStringAsFixed(0)} mm',
                      style: TextStyle(
                        color:
                            brightness == Brightness.light
                                ? Colors.blue
                                : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            barPointers: <LinearBarPointer>[
              LinearBarPointer(
                value: _maximumLevel.toDouble(),
                enableAnimation: true,
                thickness: 180,
                offset: 18,
                position: LinearElementPosition.outside,
                color: Colors.transparent,
                child: CustomPaint(
                  painter: CustomPathPainter(
                    color: Colors.blue,
                    waterLevel: widget.precipitation.toDouble(),
                    maximumPoint: _maximumLevel.toDouble(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
