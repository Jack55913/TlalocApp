// import 'dart:typed_data';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/date.dart';
import 'package:tlaloc/src/models/lluvia/send_rain.dart';
import 'package:tlaloc/src/resources/onboarding/common_select.dart';
import 'package:tlaloc/src/ui/screens/home/home_widget_classes.dart';
import 'package:tlaloc/src/ui/widgets/measures/save_button.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/ui/widgets/objects/text_field.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class AddScreen extends StatefulWidget {
  final Measurement? measurement;

  const AddScreen({super.key, this.measurement});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late TextEditingController _precipitationController;
  bool pluviometer = false;

  File? newImage;
  Uint8List? newWebImage; // Para imagenes web
  final ImagePicker picker = ImagePicker();

  DateTime dateTime = DateTime.now();
  num precipitation = 0; // Variable no-nullable
  String? uploader = FirebaseAuth.instance.currentUser?.displayName;
  String path = 'sounds/correcto.mp3';
  var player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _precipitationController = TextEditingController(
      text: widget.measurement?.precipitation?.toStringAsFixed(1) ?? '0',
    );

    if (widget.measurement != null) {
      precipitation =
          widget.measurement!.precipitation ?? 0; // Conversión segura
      uploader = widget.measurement!.uploader;
      dateTime = widget.measurement!.dateTime!;
    }
  }

  @override
  void dispose() {
    _precipitationController.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          Provider.of<AppState>(context, listen: false).newWebImage = bytes;
          newImage = null;
        });
      } else {
        setState(() {
          newImage = File(pickedFile.path);
          Provider.of<AppState>(context, listen: false).newWebImage = null;
        });
      }
    }
  }

  Future<void> pickImageC() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          Provider.of<AppState>(context, listen: false).newWebImage = bytes;
          newImage = null;
        });
      } else {
        setState(() {
          newImage = File(pickedFile.path);
          Provider.of<AppState>(context, listen: false).newWebImage = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Brightness brightness = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<GoogleSignInProvider>(
            builder: (context, signIn, child) {
              String place = Provider.of<AppState>(context).paraje;
              return AutoSizeText(
                place,
                style: const TextStyle(fontSize: 24, fontFamily: 'FredokaOne'),
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
                      state.addMeasurement(
                        uploader: uploader!,
                        precipitation: precipitation,
                        time: dateTime,
                        image: newImage,
                        pluviometer: pluviometer,
                      );
                      // state.newWebImage = null;
                      await player.play(AssetSource(path));
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      state.updateMeasurement(
                        uploaderId: widget.measurement!.uploaderId!,
                        id: widget.measurement!.id,
                        uploader: uploader!,
                        precipitation: precipitation,
                        time: dateTime,
                        image: newImage,
                        oldImage: widget.measurement!.imageUrl,
                        pluviometer: pluviometer,
                      );
                      await player.play(AssetSource(path));
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('¡Error al guardar la medición!'),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Consumer<GoogleSignInProvider>(
                  builder: (context, signIn, child) {
                    final name =
                        FirebaseAuth.instance.currentUser?.displayName ?? '';
                    return MyTextFormField(
                      initialValue: uploader ?? name,
                      helperText: '1. Escriba nombre completo',
                      hintText: 'Nombre',
                      icon: const Icon(Icons.person, color: Colors.blueGrey),
                      onChanged: (String value) {
                        setState(() => uploader = value);
                      },
                      textInputType: TextInputType.name,
                    );
                  },
                ),
                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.dark3
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red[300],
                      child: Icon(Icons.place, color: Colors.red[900]),
                    ),
                    title: Text(
                      'Estás ubicado en: "${Provider.of<AppState>(context).paraje}"',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'FredokaOne',
                      ),
                    ),
                    subtitle: const Text('2. Elige el paraje correctamente'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommonSelectPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.dark3
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RainInputWidget(
                      precipitation: precipitation,
                      onChanged: (value) {
                        setState(() {
                          precipitation = value;
                        });
                      },
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.dark3
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Datetime(
                    updateDateTime: (value) {
                      dateTime = value;
                    },
                  ),
                ),

                // TODO: AQUÍ VA LA SECCIÓN PARA ENVIAR FOTOS A GOOGLE STORAGE
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.dark3
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const ContactUsListTile(
                    title: 'Mandar fotografía',
                    title2:
                        '5. Toma una foto del pluviómetro y mándala por WhatsApp',
                    message:
                        'https://api.whatsapp.com/send?phone=5630908507&text=%C2%A1Mira!%20en%20el%20paraje%20%22%20%22%20llovi%C3%B3%20%22%20%22mm,%20adjunto%20fotograf%C3%ADa%20del%20d%C3%ADa%20de%20hoy',
                  ),
                ),
                SizedBox(height: 20),

                // Container(
                //   decoration: BoxDecoration(
                //     color:
                //         Theme.of(context).brightness == Brightness.dark
                //             ? AppColors.dark3
                //             : Colors.transparent,
                //     borderRadius: BorderRadius.circular(12.0),
                //   ),
                //   padding: const EdgeInsets.all(16.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         '3. Tomar foto del pluviómetro',
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontFamily: 'FredokaOne',
                //         ),
                //       ),
                //       const SizedBox(height: 8),
                //       const Text(
                //         '4. Selecciona una imagen',
                //         style: TextStyle(fontSize: 14),
                //       ),
                //       const SizedBox(height: 16),

                //       // Mostrar imagen seleccionada si existe
                //       if (newImage != null ||
                //           (kIsWeb &&
                //               Provider.of<AppState>(context).newWebImage !=
                //                   null))
                //         Container(
                //           margin: const EdgeInsets.only(bottom: 16),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             border: Border.all(color: Colors.grey.shade300),
                //           ),
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(8),
                //             child:
                //                 kIsWeb
                //                     ? Image.memory(
                //                       Provider.of<AppState>(
                //                         context,
                //                       ).newWebImage!,
                //                       width: 200,
                //                       height: 200,
                //                       fit: BoxFit.cover,
                //                     )
                //                     : Image.file(
                //                       newImage!,
                //                       width: 200,
                //                       height: 200,
                //                       fit: BoxFit.cover,
                //                     ),
                //           ),
                //         ),

                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           ElevatedButton.icon(
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: Colors.green[300],
                //               foregroundColor: Colors.green[900],
                //             ),
                //             onPressed: () {
                //               if (kIsWeb) {
                //                 pickImage();
                //               } else {
                //                 pickImageC();
                //               }
                //             },
                //             icon: const Icon(Icons.camera_alt),
                //             label: const Text('Cámara'),
                //           ),

                //           ElevatedButton.icon(
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: Colors.blue[300],
                //               foregroundColor: Colors.blue[900],
                //             ),
                //             onPressed: pickImage,
                //             icon: const Icon(Icons.image),
                //             label: const Text('Galería'),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.dark3
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SwitchListTile(
                    title: const Text(
                      'Reinicio de mediciones',
                      style: TextStyle(fontSize: 18, fontFamily: 'FredokaOne'),
                    ),
                    value: pluviometer,
                    secondary: CircleAvatar(
                      backgroundColor: Colors.teal[300],
                      child: Icon(Icons.output, color: Colors.teal[900]),
                    ),
                    subtitle: const Text(
                      '6. Vaciar pluviómetro (sólo personal capacitado)',
                    ),
                    onChanged: (bool value) {
                      setState(() => pluviometer = value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
