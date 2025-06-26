import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'src/app.dart'; 

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar estrategia de URL limpia (sin #)
  setPathUrlStrategy();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configuración de Firestore: persistencia y caché ilimitado
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // Registrar licencias personalizadas (Google Fonts)
  _registerLicenses();

  // Iniciar la aplicación
  runApp( const MyApp());
}

/// Registrar licencias de fuentes y otros assets
void _registerLicenses() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

