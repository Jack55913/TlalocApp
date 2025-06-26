import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/core/app_router.dart';
import 'package:tlaloc/src/core/providers/app_providers.dart';
import 'package:tlaloc/src/models/constants.dart';  

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: Builder(
        builder:
            (context) => MaterialApp(
              title: appName,
              debugShowCheckedModeBanner: false,
              theme: appLightTheme,
              darkTheme: appDarkTheme,
              themeMode: ThemeMode.system,
              initialRoute: '/',
              onGenerateRoute: generateRoute,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
      ),
    );
  }
}
