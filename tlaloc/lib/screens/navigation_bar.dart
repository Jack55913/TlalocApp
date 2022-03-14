// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/page/add.dart';
import 'package:tlaloc/page/data.dart';
import 'package:tlaloc/page/home.dart';
import 'package:tlaloc/page/profile.dart';
import 'package:tlaloc/screens/settings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 0;

  final screns = [
    HomeScreen(),
    DataScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.person, size: 30),
    ];

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: AppColors.dark2,
          title: const Text('Tláloc App',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FredokaOne',
                fontSize: 24,
                letterSpacing: 2,
              )),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              tooltip: 'Show Information',
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Registra datos pluviales'),
                  content: const Text(
                      'Colabora con Tláloc App, en la obtención de datos para analizar los cambios en los patrones de lluvia a causa del cambio climático.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Siguiente'),
                      child: const Text('Siguiente'),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfigureScreen()),
                );
              },
              child: CircleAvatar(
                maxRadius: 16,
                backgroundImage: ExactAssetImage("assets/images/img-1.png"),
              ),
            ),
          ],
        ),
        body: screns[index],
        floatingActionButton: SafeArea(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddScreen()),
              );
            },
            backgroundColor: AppColors.green1,
            child: const Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            height: 60.0,
            // ignore: prefer_const_literals_to_create_immutables
            color: AppColors.dark2,
            buttonBackgroundColor: AppColors.green1,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
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
