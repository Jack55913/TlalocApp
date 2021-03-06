import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/firebase_options.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tlaloc/page/conditional_onboarding_page.dart';
import 'package:tlaloc/screens/community.dart';
import 'package:tlaloc/screens/credits.dart';
import 'package:tlaloc/screens/home/kernel.dart';
import 'package:tlaloc/screens/settings/info.dart';
import 'package:tlaloc/screens/settings/politics.dart';
import 'package:tlaloc/screens/settings/privacy.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  //Para el inicio de sesión por google
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Modo sin conexión:
  FirebaseFirestore.instance.settings = const Settings(
    // cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    persistenceEnabled: true,
  );
  runApp(const MyApp());
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context) => AppState()),
        ChangeNotifierProvider<GoogleSignInProvider>(
            create: (context) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
        // localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        // supportedLocales: const [Locale('es', 'MX')],
        title: appName,
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const ConditionalOnboardingPage(),
          '/home': (context) => const HomePage(),
          '/credits': (context) => const CreditsPage(),
          '/politics': (context) => const PoliticPage(),
          '/privacy': (context) => const PrivacyPage(),
          '/info': (context) => const InfoProyectPage(),
          '/community': (context) => const CommunityPage(),
        },
        // home:GraphsScreen(),
      ),
    );
  }
}