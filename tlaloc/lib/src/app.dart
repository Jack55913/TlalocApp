import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/conditional_onboarding_page.dart';
import 'package:tlaloc/src/ui/screens/settings/community.dart';
import 'package:tlaloc/src/ui/screens/settings/credits.dart';
import 'package:tlaloc/src/ui/screens/settings/info.dart';
import 'package:tlaloc/src/ui/screens/settings/politics.dart';
import 'package:tlaloc/src/ui/screens/settings/privacy.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/google_sign_in.dart';

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
          '/credits': (context) => const CreditsPage(),
          '/politics': (context) => const PoliticPage(),
          '/privacy': (context) => const PrivacyPage(),
          '/info': (context) => const InfoProyectPage(),
          '/community': (context) => const CommunityPage(),
        },
      ),
    );
  }
}
