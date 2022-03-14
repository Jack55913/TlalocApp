import 'package:flutter/material.dart';
import 'package:tlaloc/api/sheets/user_sheets_api.dart';
import 'package:tlaloc/page/create_sheets_page.dart';
import 'package:tlaloc/screens/navigation_bar.dart';
import 'package:tlaloc/screens/onbording.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tláloc App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: 
          Onboarding(),
          // const BottomNavBar(),

    );
  }
}
