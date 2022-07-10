// ignore_for_file: prefer__literals_to_create_immutables, prefer__ructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/page/add.dart';
import 'package:tlaloc/page/data.dart';
import 'package:tlaloc/page/home.dart';
import 'package:tlaloc/page/graphscreen.dart';
import 'package:tlaloc/screens/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFabVisable = true;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 0;

  final screns = [
    AddScreen(),
    HomeScreen(),
    DataScreen(),
    GraphsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.add, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.menu_book_rounded, size: 30),
      Icon(Icons.bar_chart_rounded, size: 30),
    ];

    return Scaffold(
        extendBody: true,
        body: screns[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            height: 60.0,
            color: Colors.transparent,
            buttonBackgroundColor: AppColors.blue1,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 800),
            items: items,
            index: index,
            onTap: (index) {
              setState(() {
                this.index = index;
              });
            },
            letIndexChange: (index) => true,
          ),
        ));
  }
}

class InfoButton extends StatelessWidget {
  InfoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      tooltip: 'Mostrar información',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Registra datos de lluvia'),
          content: Text(
              'Colabora con Tláloc App, en la obtención de datos para analizar los patrones de lluvia en el monte Tláloc. Tendremos tres campañas de monitoreo en los siguientes periodos: del 15 de Julio al 15 de Septiembre, del 21 de Octubre al 10 de Diciembre y del 4 de marzo al 29 de Abril'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Siguiente'),
              child: Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: GestureDetector(
        child: CircleAvatar(
          foregroundImage: FirebaseAuth.instance.currentUser == null
              ? NetworkImage(
                  'data:image/png;base64,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',
                  scale: 0.5,
                  )
              : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfigureScreen()),
          );
        },
      ),
    );
  }
}
