

// // ignore_for_file: library_private_types_in_public_api, avoid_print, avoid_unnecessary_containers

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tlaloc/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:tlaloc/src/models/google_sign_in.dart';
// import 'package:url_strategy/url_strategy.dart';
// import 'package:provider/provider.dart';
// import 'package:tlaloc/src/models/app_state.dart';
// import 'package:tlaloc/src/models/constants.dart';
// import 'package:tlaloc/src/ui/screens/settings/community.dart';
// import 'package:tlaloc/src/ui/screens/settings/credits.dart';
// import 'package:tlaloc/src/ui/screens/settings/info.dart';
// import 'package:tlaloc/src/ui/screens/settings/politics.dart';
// import 'package:tlaloc/src/ui/screens/settings/privacy.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tlaloc/src/ui/widgets/backgrounds/empty_state.dart';
// import 'package:concentric_transition/concentric_transition.dart';
// import 'package:lottie/lottie.dart';
// import 'package:tlaloc/src/ui/widgets/cards/onbording_cards.dart';
// import 'package:tlaloc/src/resources/onboarding/sign_in.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:tlaloc/src/ui/screens/dir/data.dart';
// import 'package:tlaloc/src/ui/screens/dir/graphscreen.dart';
// import 'package:tlaloc/src/ui/screens/dir/home.dart';
// import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:tlaloc/src/models/custompathpainter.dart';
// import 'package:tlaloc/src/models/date.dart';
// import 'package:tlaloc/src/resources/onboarding/common_select.dart';
// import 'package:tlaloc/src/ui/screens/home/home_widget_classes.dart';
// import 'package:tlaloc/src/ui/widgets/measures/save_button.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
// import 'package:tlaloc/src/ui/widgets/objects/text_field.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   setPathUrlStrategy();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   FirebaseFirestore.instance.settings = const Settings(
//     persistenceEnabled: true,
//   );

//   runApp(const MyApp());
//   LicenseRegistry.addLicense(() async* {
//     final license = await rootBundle.loadString('google_fonts/OFL.txt');
//     yield LicenseEntryWithLineBreaks(['google_fonts'], license);
//   });
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<AppState>(create: (context) => AppState()),
//         ChangeNotifierProvider<GoogleSignInProvider>(
//             create: (context) => GoogleSignInProvider()),
//       ],
//       child: MaterialApp(
//         title: appName,
//         theme: darkTheme,
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/',
//         routes: {
//           '/': (context) => const ConditionalOnboardingPage(),
//           '/credits': (context) => const CreditsPage(),
//           '/politics': (context) => const PoliticPage(),
//           '/privacy': (context) => const PrivacyPage(),
//           '/info': (context) => const InfoProyectPage(),
//           '/community': (context) => const CommunityPage(),
//         },
//       ),
//     );
//   }
// }

// class SplashScreen extends StatelessWidget {
//   final Widget nextScreen;

//   const SplashScreen({Key? key, required this.nextScreen}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       duration: 500,
//       backgroundColor: AppColors.dark1,
//       splashTransition: SplashTransition.fadeTransition,
//       splash: Image.asset(
//         'assets/images/tlaloc_logo.png',
//         fit: BoxFit.cover,
//       ),
//       nextScreen: nextScreen,
//     );
//   }
// }

// class ConditionalOnboardingPage extends StatelessWidget {
//   const ConditionalOnboardingPage({Key? key}) : super(key: key);

//   Future<bool> get hasFinishedOnboarding async {
//     var prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('hasFinishedOnboarding') ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: hasFinishedOnboarding,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           bool hasFinishedOnboarding = snapshot.data!;
//           if (hasFinishedOnboarding) {
//             return const HomePage();
//           } else {
//             return SplashScreen(nextScreen: Onboarding());
//           }
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text(
//                 'Ocurrió un error',
//                 style: TextStyle(
//                   fontFamily: 'FredokaOne',
//                 ),
//               ),
//             ),
//             body: EmptyState(
//                 'Intenta liberar espacio en tu dispositivo. Si el error persiste, manda correo a tlloc@googlegroups.com. El error es ${snapshot.error}'),
//           );
//         } else {
//           return Center(
//             child: Container(),
//           );
//         }
//       },
//     );
//   }
// }

// class Onboarding extends StatelessWidget {
//   Onboarding({Key? key}) : super(key: key);

//   final List<CardPlanetData> data = [
//     CardPlanetData(
//       title: appName,
//       subtitle: "Ciencia para tí y para todos",
//       image: const AssetImage("assets/images/img-1.png"),
//       backgroundColor: AppColors.blue1,
//       titleColor: Colors.white,
//       subtitleColor: Colors.white,
//       background: LottieBuilder.asset("assets/animation/bg-1.json"),
//     ),
//     CardPlanetData(
//       title: "Te damos la bienvenida",
//       subtitle:
//           "Ya eres parte del proyecto ''Ciencia ciudadana para el monitoreo de la lluvia en el monte Tláloc'' ",
//       image: const AssetImage("assets/images/img-2.png"),
//       backgroundColor: Colors.white,
//       titleColor: AppColors.green1,
//       subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
//       background: LottieBuilder.asset("assets/animation/bg-2.json"),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ConcentricPageView(
//         onFinish: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const SignUpWidget()),
//           );
//         },
//         colors: data.map((e) => e.backgroundColor).toList(),
//         itemCount: data.length,
//         itemBuilder: (int index) {
//           return CardPlanet(data: data[index]);
//         },
//       ),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isFabVisable = true;
//   final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//   int index = 0;

//   final screens = [
//     const AddScreen(),
//     const HomeScreen(),
//     const DataScreen(),
//     const GraphsScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final items = <Widget>[
//       const Icon(Icons.add, size: 30),
//       const Icon(Icons.home, size: 30),
//       const Icon(Icons.menu_book_rounded, size: 30),
//       const Icon(Icons.bar_chart_rounded, size: 30),
//     ];

//     return Scaffold(
//         extendBody: true,
//         body: screens[index],
//         bottomNavigationBar: Theme(
//           data: Theme.of(context)
//               .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
//           child: CurvedNavigationBar(
//             key: _bottomNavigationKey,
//             height: 60.0,
//             color: Colors.transparent,
//             buttonBackgroundColor: AppColors.blue1,
//             backgroundColor: Colors.transparent,
//             animationCurve: Curves.easeInOut,
//             animationDuration: const Duration(milliseconds: 800),
//             items: items,
//             index: index,
//             onTap: (index) {
//               setState(() {
//                 this.index = index;
//               });
//             },
//             letIndexChange: (index) => true,
//           ),
//         ));
//   }
// }

// class AddScreen extends StatefulWidget {
//   final Measurement? measurement;

//   const AddScreen({
//     Key? key,
//     this.measurement,
//   }) : super(key: key);

//   @override
//   State<AddScreen> createState() => _AddScreenState();
// }

// // int _counter = 0;
// bool pluviometer = false;

// class _AddScreenState extends State<AddScreen> {
//   File? newImage;
//   DateTime dateTime = DateTime.now();
//   num? precipitation = 0;

//   String path = 'sounds/correcto.mp3';

//   var player = AudioPlayer(); //+

//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);

//       if (image == null) return;

//       final File imageTemp = File(image.path);

//       setState(() => newImage = imageTemp);
//     } on PlatformException catch (e) {
//       print('Falló al obtener la imágen: $e');
//     }
//   }

//   void _incrementCounter() {
//     setState(() {
//       // _counter++;
//     });
//   }

// // PLUVIOMETER:
//   final num _minimumLevel = 0;
//   final num _maximumLevel = 160;

//   @override
//   Widget build(BuildContext context) {
//     if (widget.measurement != null) {
//       dateTime = widget.measurement!.dateTime!;
//       precipitation = widget.measurement!.precipitation;
//     }
//     final Brightness brightness = Theme.of(context).brightness;

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Consumer<GoogleSignInProvider>(
//             builder: (context, signIn, child) {
//               String place = Provider.of<AppState>(context).paraje;
//               return TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const CommonSelectPage()),
//                   );
//                 },
//                 child: AutoSizeText(
//                   place,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     color: Colors.white,
//                     fontFamily: 'FredokaOne',
//                   ),
//                 ),
//               );
//             },
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ButtonWidget(
//                 onClicked: () async {
//                   try {
//                     final state = Provider.of<AppState>(context, listen: false);
//                     if (widget.measurement == null) {
//                       // Crear medición
//                       state.addMeasurement(
//                         precipitation: precipitation!,
//                         time: dateTime,
//                         image: newImage,
//                         pluviometer: pluviometer,
//                       );
//                       state.addRealMeasurement(
//                         precipitation: precipitation!,
//                         time: dateTime,
//                         image: newImage,
//                         pluviometer: pluviometer,
//                       );
//                       // TODO: QUE SE Muestra el banner
//                       // showBanner;
//                       _incrementCounter;
//                       player.play(AssetSource(path));
//                       Navigator.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute<void>(
//                               builder: (BuildContext context) {
//                         return const HomePage();
//                       }), (Route<dynamic> route) => false);
//                     } else {
//                       // Edita una medición ya existente
//                       state.updateMeasurement(
//                         id: widget.measurement!.id,
//                         precipitation: precipitation!,
//                         time: dateTime,
//                         image: newImage,
//                         oldImage: widget.measurement!.imageUrl,
//                         pluviometer: pluviometer,
//                       );
//                       player.play(AssetSource(path));
//                       // showBanner2;
//                       Navigator.pop(context);
//                       Navigator.pop(context);
//                       // Works around the previous page being a stateful widget
//                       // Navigator.pop(context);
//                     }
//                   } catch (e) {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text(
//                             '¡No ingresaste la medición correctamente, inténtalo nuevamente!'),
//                         content: Text('$e'),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.red[300],
//                   child: Icon(
//                     Icons.place,
//                     color: Colors.red[900],
//                   ),
//                 ),
//                 title: const Text('Elige un Paraje'),
//                 subtitle: Text(
//                     'Estás ubicado en: "${Provider.of<AppState>(context).paraje}"'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const CommonSelectPage()),
//                   );
//                 },
//               ),
//               const Divider(
//                 height: 20,
//                 thickness: 1,
//               ),
//               Consumer<GoogleSignInProvider>(builder: (context, signIn, child) {
//                 final name = FirebaseAuth.instance.currentUser?.displayName;
//                 if (name == null) {
//                   name == '';
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: MyTextFormField(
//                     initialValue: name,
//                     helperText: 'Nombre',
//                     hintText: 'Nombre',
//                     icon: const Icon(
//                       Icons.person,
//                       color: Colors.green,
//                     ),
//                     onChanged: (value) {
//                       //  = value.toString();
//                     },
//                     textInputType: TextInputType.name,
//                   ),
//                 );
//               }),
//               const Divider(
//                 thickness: 1,
//               ),
//               ListTile(
//                 title: TextFormField(
//                   // autofocus: true,
//                   cursorColor: Colors.indigo,
//                   // onEditingComplete: , Sirve para que el botón de enter en el teclado envíe la medición automáticamente
//                   // onSaved: (newValue) => precipitation,
//                   // focusNode: FocusNode(canRequestFocus: _pluviometer),
//                   initialValue: precipitation?.toString(),
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontFamily: 'FredokaOne',
//                   ),
//                   textAlign: TextAlign.left,
//                   decoration: InputDecoration(
//                     icon: CircleAvatar(
//                       backgroundColor: Colors.blue[300],
//                       child: Icon(
//                         Icons.cloud,
//                         color: Colors.blue[900],
//                       ),
//                     ),
//                     helperText: 'Ingresar Medición',
//                     hintText:
//                         'Recuerda ubicarte al nivel del agua para observar',
//                   ),
//                   onChanged: (value) {
//                     precipitation = num.tryParse(value);
//                   },
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   keyboardType: TextInputType.number,
//                   // autocorrect: true,
//                   autofocus: true,
//                   maxLength: 5,
//                   // controller: controller,
//                   validator: RangeValidator(
//                     min: 0.0,
//                     max: 160.0,
//                     errorText: 'Debe ser entre 0 y 160',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 350,
//                 child: SfLinearGauge(
//                   minimum: _minimumLevel.toDouble(),
//                   maximum: _maximumLevel.toDouble(),
//                   orientation: LinearGaugeOrientation.vertical,
//                   interval: 10,
//                   axisTrackStyle: const LinearAxisTrackStyle(
//                     thickness: 2,
//                   ),
//                   markerPointers: <LinearMarkerPointer>[
//                     LinearWidgetPointer(
//                       value: precipitation!.toDouble(),
//                       enableAnimation: true,
//                       onChanged: (dynamic value) {
//                         setState(() {
//                           precipitation = value as num;
//                         });
//                       },
//                       child: Material(
//                         elevation: 4.0,
//                         shape: const CircleBorder(),
//                         clipBehavior: Clip.hardEdge,
//                         color: Colors.blue,
//                         child: Ink(
//                           width: 32.0,
//                           height: 32.0,
//                           child: InkWell(
//                             splashColor: Colors.grey,
//                             hoverColor: Colors.blueAccent,
//                             onTap: () {},
//                             child: Center(
//                               child: precipitation == _minimumLevel
//                                   ? const Icon(Icons.keyboard_arrow_up_outlined,
//                                       color: Colors.white, size: 18.0)
//                                   : precipitation == _maximumLevel
//                                       ? const Icon(
//                                           Icons.keyboard_arrow_down_outlined,
//                                           color: Colors.white,
//                                           size: 18.0)
//                                       : const RotatedBox(
//                                           quarterTurns: 3,
//                                           child: Icon(Icons.code_outlined,
//                                               color: Colors.white, size: 18.0)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     LinearWidgetPointer(
//                       value: precipitation!.toDouble(),
//                       enableAnimation: true,
//                       markerAlignment: LinearMarkerAlignment.end,
//                       offset: 67,
//                       position: LinearElementPosition.outside,
//                       child: SizedBox(
//                         width: 60,
//                         height: 20,
//                         child: Center(
//                           child: Text(
//                             '${precipitation!.toStringAsFixed(1)} mm',
//                             style: TextStyle(
//                                 color: brightness == Brightness.light
//                                     ? Colors.black
//                                     : Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                   barPointers: <LinearBarPointer>[
//                     LinearBarPointer(
//                       value: _maximumLevel.toDouble(),
//                       enableAnimation: true,
//                       thickness: 150,
//                       offset: 18,
//                       position: LinearElementPosition.outside,
//                       color: Colors.transparent,
//                       child: CustomPaint(
//                           painter: CustomPathPainter(
//                               color: Colors.blue,
//                               waterLevel: precipitation!.toDouble(),
//                               maximumPoint: _maximumLevel.toDouble())),
//                     )
//                   ],
//                 ),
//               ),
//               const Divider(
//                 height: 20,
//                 thickness: 1,
//               ),
//               Datetime(
//                 updateDateTime: (value) {
//                   dateTime = value;
//                 },
//               ),
//               const Divider(
//                 thickness: 1,
//               ),
//               FutureBuilder<ConnectivityResult>(
//                 future: Connectivity().checkConnectivity(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError ||
//                       (snapshot.hasData &&
//                           snapshot.data == ConnectivityResult.none)) {
//                     return const Text(
//                         'No se puede subir imágenes sin internet (aún).\n Súbelo más tarde desde la galeria');
//                   } else {
//                     return Column(
//                       children: [
//                         // const SizedBox(height: 15),
//                         DarkContainerWidget(
//                           data: DarkContainer(
//                             fill: Container(
//                               child: const Padding(
//                                 padding: EdgeInsets.all(16.0),
//                                 child: Text(
//                                   'Toma una foto del pluviómetro y mándala por whatsapp',
//                                   textAlign: TextAlign.start,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontFamily: 'FredokaOne',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//               const ContactUsButton(
//                   title: 'Mandar fotografía',
//                   message:
//                       'https://api.whatsapp.com/send?phone=5630908507&text=%C2%A1Mira!%20en%20el%20ejido%20%22%20%22%20llovi%C3%B3%20%22%20%22mm,%20adjunto%20fotograf%C3%ADa%20del%20d%C3%ADa%20de%20hoy'),
//               const Divider(
//                 height: 20,
//                 thickness: 1,
//               ),
//               SwitchListTile(
//                 title: const Text(
//                   'Reinicio de mediciones',
//                 ),
//                 value: pluviometer,
//                 secondary: CircleAvatar(
//                     backgroundColor: Colors.teal[300],
//                     child: Icon(Icons.water_drop, color: Colors.teal[900])),
//                 subtitle: const Text('Sólo personal capacitado'),
//                 onChanged: (bool value) {
//                   setState(() => pluviometer = value);
//                 },
//               ),
//               const Divider(
//                 height: 20,
//                 thickness: 1,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
