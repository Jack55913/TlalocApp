// ignore_for_file: avoid_print, avoid_unnecessary_containers
import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tlaloc/src/models/custompathpainter.dart';
import 'package:tlaloc/src/models/date.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:tlaloc/src/ui/screens/home/home_widget_classes.dart';
import 'package:tlaloc/src/ui/widgets/measures/save_button.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/objects/text_field.dart';

class AddScreen extends StatefulWidget {
  final Measurement? measurement;

  const AddScreen({Key? key, this.measurement}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool pluviometer = false;
  File? newImage;
  DateTime dateTime = DateTime.now();
  num? precipitation = 0;
  String? uploader = FirebaseAuth.instance.currentUser?.displayName;
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

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => newImage = imageTemp);
    } on PlatformException catch (e) {
      print('Falló al obtener la imágen: $e');
    }
  }

  // void _incrementCounter() {
  //   setState(() {
  //     // _counter++;
  //   });
  // }

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
      precipitation = widget.measurement!.precipitation;
      uploader = widget.measurement!.uploader;
      dateTime = widget.measurement!.dateTime!;
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
                        uploader: uploader!,
                        precipitation: precipitation!,
                        time: dateTime,
                        image: newImage,
                        pluviometer: pluviometer,
                      );
                      state.addRealMeasurement(
                        uploader: uploader!,
                        precipitation: precipitation!,
                        time: dateTime,
                        image: newImage,
                        pluviometer: pluviometer,
                      );
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
                        uploader: uploader!,
                        precipitation: precipitation!,
                        time: dateTime,
                        image: newImage,
                        oldImage: widget.measurement!.imageUrl,
                        pluviometer: pluviometer,
                      );
                      state.updateRealMeasurement(
                        id: widget.measurement!.id,
                        uploader: uploader!,
                        precipitation: precipitation!,
                        time: dateTime,
                        image: newImage,
                        oldImage: widget.measurement!.imageUrl,
                        pluviometer: pluviometer,
                      );
                      player.play(AssetSource(path));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // Works around the previous page being a stateful widget
                      // Navigator.pop(context);
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                            '¡No ingresaste la medición correctamente, inténtalo nuevamente!'),
                        content: Text('$e'),
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
              Consumer<GoogleSignInProvider>(builder: (context, signIn, child) {
                final name = FirebaseAuth.instance.currentUser?.displayName;
                if (name == null) {
                  name == '';
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyTextFormField(
                    initialValue: uploader ?? name,
                    helperText: 'Nombre Completo',
                    hintText: 'Nombre',
                    icon: const Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    onChanged: (String value) {
                      setState(() => uploader = value);
                    },
                    textInputType: TextInputType.name,
                  ),
                );
              }),
              const Divider(
                thickness: 1,
              ),
              // TODO: PUNTO 4 DEL CONTRATO
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
                    helperText: 'Ingresar medición de lluvia',
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
                          child: Text(
                            '${precipitation!.toStringAsFixed(1)} mm',
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
                    return Column(
                      children: [
                        DarkContainerWidget(
                          data: DarkContainer(
                            fill: Container(
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'No se puede subir imágenes sin internet (aún).\n Toma la fotografía, anota los datos y mándala vía WhatsApp:',
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
                        // const Text(
                        //     'No se puede subir imágenes sin internet (aún).\n Toma la fotografía, anota los datos y mándala vía WhatsApp:'),
                        const ContactUsButton(
                            title: 'Mandar fotografía',
                            message:
                                'https://api.whatsapp.com/send?phone=5630908507&text=%C2%A1Mira!%20en%20el%20paraje%20%22%20%22%20llovi%C3%B3%20%22%20%22mm,%20adjunto%20fotograf%C3%ADa%20del%20d%C3%ADa%20de%20hoy'),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        DarkContainerWidget(
                          data: DarkContainer(
                            fill: Container(
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Toma una foto del pluviómetro y mándala por whatsapp',
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
                        // TODO: PUNTO 3 DEL CONTRATO
                        // const SizedBox(height: 15),
                        // ListTile(
                        //     leading: CircleAvatar(
                        //         backgroundColor: Colors.purple[300],
                        //         child: Icon(Icons.image,
                        //             color: Colors.purple[900])),
                        //     title: const Text(
                        //       " Desde la Galería",
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 16,
                        //         fontFamily: 'poppins',
                        //       ),
                        //     ),
                        //     onTap: () {
                        //       pickImage();
                        //     }),
                        // const SizedBox(height: 15),
                        // // TODO: PUNTO 3.1 DEL CONTRATO:  hacer que sirva sin wifi!!! y luego activar esto
                        // ListTile(
                        //     leading: CircleAvatar(
                        //         backgroundColor: Colors.purple[300],
                        //         child: Icon(Icons.camera_alt,
                        //             color: Colors.purple[900])),
                        //     title: const Text("Desde la Cámara",
                        //         style: TextStyle(
                        //           color: Colors.grey,
                        //           fontSize: 16,
                        //           fontFamily: 'poppins',
                        //         )),
                        //     onTap: () {
                        //       pickImageC();
                        //     }),
                        // const SizedBox(height: 20),
                        // if (newImage == null &&
                        //     widget.measurement != null &&
                        //     widget.measurement!.imageUrl != null)
                        //   Padding(
                        //     padding: const EdgeInsets.all(15.0),
                        //     child: CachedNetworkImage(
                        //       imageUrl: widget.measurement!.imageUrl!,
                        //     ),
                        //   )
                        // else
                        //   newImage != null
                        //       ? Padding(
                        //           padding: const EdgeInsets.all(15.0),
                        //           child: Image.file(newImage!),
                        //         )
                        //       : const Text(
                        //           "⚠️ No ha seleccionado ninguna imágen ⚠️",
                        //           style: TextStyle(
                        //             color: Colors.red,
                        //             fontSize: 16,
                        //             fontFamily: 'poppins',
                        //           ),
                        //         ),
                      ],
                    );
                  }
                },
              ),
              const ContactUsButton(
                  title: 'Mandar fotografía',
                  message:
                      'https://api.whatsapp.com/send?phone=5630908507&text=%C2%A1Mira!%20en%20el%20paraje%20%22%20%22%20llovi%C3%B3%20%22%20%22mm,%20adjunto%20fotograf%C3%ADa%20del%20d%C3%ADa%20de%20hoy'),
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
  }
}

class PersonalMeausreData extends StatefulWidget {
  const PersonalMeausreData({Key? key}) : super(key: key);

  @override
  State<PersonalMeausreData> createState() => _PersonalMeausreDataState();
}

late final Measurement measurement;

class _PersonalMeausreDataState extends State<PersonalMeausreData> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      // TODO: PUNTO 4.1 DEL CONTRATO Transformar a número
      // '${measurement.precipitation} mm',
      '1',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'poppins',
        fontSize: 16,
      ),
    );
  }
}
