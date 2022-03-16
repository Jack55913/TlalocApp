import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tlaloc/api/sheets/user_sheets_api.dart';
// import 'package:tlaloc/screens/navigation_bar.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:tlaloc/models/constants.dart';
// import 'models/constants.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:tlaloc/screens/onbording.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await UserSheetsApi.init();
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
    return MaterialApp(
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
      title: 'Tláloc App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/tlaloc_logo.png',
          fit: BoxFit.cover,
        ),
        nextScreen: Onboarding(),
        splashTransition: SplashTransition.decoratedBoxTransition,
      ),
      // home: Onboarding(),
      // const const BottomNavBar(),
    );
  }
}
