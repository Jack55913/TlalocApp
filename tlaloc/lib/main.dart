import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tlaloc/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tlaloc/src/app.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
void main() async {
  // Inician los comerciales (Falta hacer cuenta en ADMOB)
  // MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  // Quita el # de la url
  setPathUrlStrategy();
  //Para el inicio de sesión por google
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Modo sin conexión:
  FirebaseFirestore.instance.settings = const Settings(
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    persistenceEnabled: true,
  );
FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  runApp(const MyApp());
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });}