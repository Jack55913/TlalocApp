// ignore_for_file: library_private_types_in_public_api

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';
import 'package:tlaloc/src/ui/screens/dir/data.dart';
import 'package:tlaloc/src/ui/screens/dir/graphscreen.dart';
import 'package:tlaloc/src/ui/screens/dir/home.dart';
import 'package:tlaloc/src/ui/screens/home/profile_page.dart';
import 'package:tlaloc/src/ui/widgets/appbar/profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFabVisable = true;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 1;

  final screens = [
    const HomeScreen(),
    const AddScreen(),
    const DataScreen(),
    // const GraphsScreen(),
    const ConfigureScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.add, size: 30),
      const Icon(Icons.menu_book_rounded, size: 30),
      // const Icon(Icons.bar_chart_rounded, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            height: 60.0,
            color: Colors.transparent,
            buttonBackgroundColor: AppColors.blue1,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 800),
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
