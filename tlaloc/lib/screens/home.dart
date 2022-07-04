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
              'Colabora con Tláloc App, en la obtención de datos para analizar los patrones de lluviaen el monte Tláloc. Tendremos tres campañas de monitoreo en los siguientes periodos: del 15 de Julio al 15 de Septiembre, del 21 de Octubre al 10 de Diciembre y del 4 de marzo al 29 de Abril'),
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
                  'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png')
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
