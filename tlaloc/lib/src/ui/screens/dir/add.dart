// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tlaloc/src/models/custompathpainter.dart';
import 'package:tlaloc/src/models/date.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:tlaloc/src/ui/widgets/measures/save_button.dart';
import 'package:tlaloc/src/models/app_state.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';

class AddScreen extends StatefulWidget {
  final Measurement? measurement;
  final num? updatePrecipitation;
  final bool? updatePluviometer;

  const AddScreen(
      {Key? key,
      this.measurement,
      this.updatePluviometer,
      this.updatePrecipitation})
      : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

// TODO: IDEA: Usar la función lenght de la lista de measurements.precipitation.length
int _counter = 0;
bool pluviometer = false;

class _AddScreenState extends State<AddScreen> {
  File? newImage;
  DateTime dateTime = DateTime.now();
  num? precipitation = 0;

  String path = 'sounds/correcto.mp3';

  var player = AudioPlayer(); //+

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final File imageTemp = File(image.path);

      setState(() => newImage = imageTemp);
    } on PlatformException catch (e) {
      print('Falló al obtener la imágen: $e');
    }
  }

  // Future pickImageC() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => newImage = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Falló al obtener la imágen: $e');
  //   }
  // }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // void _decrementCounter() {
  //   setState(() {
  //     _counter--;
  //   });
  // }

// PLUVIOMETER:
  final num _minimumLevel = 0;
  final num _maximumLevel = 160;

  @override
  Widget build(BuildContext context) {
    if (widget.measurement != null) {
      dateTime = widget.measurement!.dateTime!;
      precipitation = widget.measurement!.precipitation;
    }
    final Brightness brightness = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<GoogleSignInProvider>(
            builder: (context, signIn, child) {
              String place = Provider.of<AppState>(context).paraje;
              return TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CommonSelectPage()),
                  );
                },
                child: AutoSizeText(
                  place,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'FredokaOne',
                  ),
                ),
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(
                onClicked: () async {
                  try {
                    final state = Provider.of<AppState>(context, listen: false);
                    if (widget.measurement == null) {
                      // Crear medición
                      state.addMeasurement(
                        precipitation: precipitation!,
                        time: dateTime,
                        image: newImage,
                        pluviometer: pluviometer,
                      );
                      // TODO: QUE SE Muestra el banner
                      // showBanner;
                      _incrementCounter;
                      player.play(AssetSource(path));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                        return const HomePage();
                      }), (Route<dynamic> route) => false);
                    } else {
                      // Edita una medición ya existente
                      state.updateMeasurement(
                        id: widget.measurement!.id,
                        precipitation: precipitation!,
                        time: dateTime,
                        image: newImage,
                        oldImage: widget.measurement!.imageUrl,
                        pluviometer: pluviometer,
                      );
                      player.play(AssetSource(path));
                      // showBanner2;
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // Works around the previous page being a stateful widget
                      // Navigator.pop(context);
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const SelectableText(
                            '¡No ingresaste la medición correctamente, inténtalo nuevamente!'),
                        content: SelectableText('$e'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red[300],
                  child: Icon(
                    Icons.place,
                    color: Colors.red[900],
                  ),
                ),
                title: const Text('Elige un Paraje'),
                subtitle: Text(
                    'Estás ubicado en: "${Provider.of<AppState>(context).paraje}"'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CommonSelectPage()),
                  );
                },
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              ListTile(
                title: TextFormField(
                  // autofocus: true,
                  cursorColor: Colors.indigo,
                  // onEditingComplete: , Sirve para que el botón de enter en el teclado envíe la medición automáticamente
                  // onSaved: (newValue) => precipitation,
                  // focusNode: FocusNode(canRequestFocus: _pluviometer),
                  initialValue: precipitation?.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'FredokaOne',
                  ),
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    icon: CircleAvatar(
                      backgroundColor: Colors.blue[300],
                      child: Icon(
                        Icons.cloud,
                        color: Colors.blue[900],
                      ),
                    ),
                    helperText: 'Ingresar Medición',
                    hintText:
                        'Recuerda ubicarte al nivel del agua para observar',
                  ),
                  onChanged: (value) {
                    precipitation = num.tryParse(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  // autocorrect: true,
                  autofocus: true,
                  maxLength: 5,
                  // TODO: Hacer que funcione , "save_button.dart"
                  // controller: controller,
                  validator: RangeValidator(
                    min: 0.0,
                    max: 160.0,
                    errorText: 'Debe ser entre 0 y 160',
                  ),
                ),
              ),
              SizedBox(
                height: 350,
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
                      value: precipitation!.toDouble(),
                      enableAnimation: true,
                      onChanged: (dynamic value) {
                        setState(() {
                          precipitation = value as num;
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
                              child: precipitation == _minimumLevel
                                  ? const Icon(Icons.keyboard_arrow_up_outlined,
                                      color: Colors.white, size: 18.0)
                                  : precipitation == _maximumLevel
                                      ? const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Colors.white,
                                          size: 18.0)
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
                      value: precipitation!.toDouble(),
                      enableAnimation: true,
                      markerAlignment: LinearMarkerAlignment.end,
                      offset: 67,
                      position: LinearElementPosition.outside,
                      child: SizedBox(
                        width: 60,
                        height: 20,
                        child: Center(
                          child: SelectableText(
                            // TODO: connect the text field and the pluviometer
                            precipitation!.toStringAsFixed(1) + ' mm',
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
                      enableAnimation: true,
                      thickness: 150,
                      offset: 18,
                      position: LinearElementPosition.outside,
                      color: Colors.transparent,
                      child: CustomPaint(
                          painter: CustomPathPainter(
                              color: Colors.blue,
                              waterLevel: precipitation!.toDouble(),
                              maximumPoint: _maximumLevel.toDouble())),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              Datetime(
                updateDateTime: (value) {
                  dateTime = value;
                },
              ),
              const Divider(
                thickness: 1,
              ),
              FutureBuilder<ConnectivityResult>(
                future: Connectivity().checkConnectivity(),
                builder: (context, snapshot) {
                  if (snapshot.hasError ||
                      (snapshot.hasData &&
                          snapshot.data == ConnectivityResult.none)) {
                    return const SelectableText(
                        // TODO: AQUÏ VA LA FUNCIÖN PARA QUE NO TENGA INTERNET
                        'No se puede subir imágenes sin internet (aún).\n Súbelo más tarde desde la galeria');
                  } else {
                    return Column(
                      children: [
                        // const SizedBox(height: 15),
                        DarkContainerWidget(
                          data: DarkContainer(
                            fill: Container(
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SelectableText(
                                  'Toma una foto y sube la imagen del\n pluviómetro cuando llegues a casa',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'FredokaOne',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.purple[300],
                                child: Icon(Icons.image,
                                    color: Colors.purple[900])),
                            title: const Text(
                              " Desde la Galería",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: 'poppins',
                              ),
                            ),
                            onTap: () {
                              pickImage();
                            }),
                        const SizedBox(height: 15),
                        // TODO: hacer que sirva sin wifi!!! y luego activar esto
                        // ListTile(
                        //     leading: CircleAvatar(
                        //         backgroundColor: Colors.purple[300],
                        //         child: Icon(Icons.camera_alt,
                        //             color: Colors.purple[900])),
                        //     title: const SelectableText("Desde la Cámara",
                        //         style: TextStyle(
                        //           color: Colors.grey,
                        //           fontSize: 16,
                        //           fontFamily: 'poppins',
                        //         )),
                        //     onTap: () {
                        //       pickImageC();
                        //     }),
                        const SizedBox(height: 20),
                        if (newImage == null &&
                            widget.measurement != null &&
                            widget.measurement!.imageUrl != null)
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CachedNetworkImage(
                              imageUrl: widget.measurement!.imageUrl!,
                            ),
                          )
                        else
                          newImage != null
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.file(newImage!),
                                )
                              : const SelectableText(
                                  "⚠️ No ha seleccionado ninguna imágen ⚠️",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: 'poppins',
                                  ),
                                ),
                      ],
                    );
                  }
                },
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              SwitchListTile(
                title: const Text(
                  'Reinicio de mediciones',
                ),
                value: pluviometer,
                secondary: CircleAvatar(
                    backgroundColor: Colors.teal[300],
                    child: Icon(Icons.water_drop, color: Colors.teal[900])),
                subtitle: const Text('Sólo personal capacitado'),
                onChanged: (bool value) {
                  setState(() => pluviometer = value);
                },
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
    // TODO: Hacer que sirva el banner luego de enviar medición

    // void showBanner() => ScaffoldMessenger.of(context).showMaterialBanner(
    //       MaterialBanner(
    //         backgroundColor: AppColors.green1,
    //         leading: Icon(Icons.check),
    //         content: SelectableText(
    //           '¡Has agregado una medición!',
    //           style: TextStyle(
    //             fontFamily: 'poppins',
    //             fontSize: 16,
    //           ),
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    //             },
    //             child: SelectableText(
    //               'OK',
    //               style: TextStyle(
    //                 fontFamily: 'poppins',
    //                 fontSize: 16,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );

    // void showBanner2() => ScaffoldMessenger.of(context).showMaterialBanner(
    //       MaterialBanner(
    //         leading: Icon(Icons.check),
    //         content: SelectableText(
    //           '¡Listo, se ha modificado su medición!',
    //           style: TextStyle(
    //             fontFamily: 'poppins',
    //             fontSize: 16,
    //           ),
    //         ),
    //         backgroundColor: AppColors.green1,
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    //             },
    //             child: SelectableText(
    //               'OK',
    //               style: TextStyle(
    //                 fontFamily: 'poppins',
    //                 fontSize: 16,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
  }

// class PersonalMeausreData extends StatelessWidget {
//   const PersonalMeausreData({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SelectableText(
//       '$_counter',
//       style: const TextStyle(
//         color: Colors.white,
//         fontFamily: 'poppins',
//         fontSize: 16,
//       ),
//     );
//   }
// }
}

class PersonalMeausreData extends StatefulWidget {
  const PersonalMeausreData({Key? key}) : super(key: key);

  @override
  State<PersonalMeausreData> createState() => _PersonalMeausreDataState();
}

class _PersonalMeausreDataState extends State<PersonalMeausreData> {
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      '$_counter',
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'poppins',
        fontSize: 16,
      ),
    );
  }
}
