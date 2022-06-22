import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/api/sheets/user_sheets_api.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/google_sign_in.dart';
import 'package:tlaloc/onboarding/onbording.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tlaloc/page/conditional_onboarding_page.dart';
//import 'package:firebase_analytics/observer.dart';
// import 'package:tlaloc/screens/navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //Para el inicio de sesión por google
  await UserSheetsApi.init(); // Para el API de googleSheets de la base de datos
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
        // navigatorObservers: [
        //   FirebaseAnalyticsObserver(analytics: analytics),
        // ],
        title: appName,
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const ConditionalOnboardingPage(),
      ),
    );
  }
}
