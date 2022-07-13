import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/firebase_options.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tlaloc/onboarding/sign_in.dart';
import 'package:tlaloc/page/conditional_onboarding_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tlaloc/screens/credits.dart';
import 'package:tlaloc/screens/politics.dart';
import 'package:tlaloc/screens/privacy.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
      ); 
      //Para el inicio de sesión por google
  // Modo sin conexión:
  FirebaseFirestore.instance.settings = const Settings(
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
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('es', 'MX')],
        title: appName,
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const ConditionalOnboardingPage(),
          '/signup': (context) => const SignUpWidget(),
          '/credits': (context) => const CreditsPage(),
          '/politics': (context) => const PoliticPage(),
          '/privacy': (context) => const PrivacyPage(),
        },
        // home:GraphsScreen(),
      ),
    );
  }
}
