import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/resources/statics/graphs/graph2.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';
import 'package:tlaloc/src/ui/screens/dir/data.dart';
import 'package:tlaloc/src/ui/screens/dir/home.dart';
import 'package:tlaloc/src/ui/screens/home/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tlaloc/src/ui/widgets/data_screen_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

  int globalNotificationCount = 0;
  bool hasSeenNotifications = false;

  late final List<Widget> _screens = const [
    HomeScreen(),
    AddScreen(),
    DataScreen(),
    BarGraph(),
    ConfigureScreen(),
  ];
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('notifications')
        .doc('globalCounter')
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists) {
            setState(() {
              globalNotificationCount = snapshot.data()?['count'] ?? 0;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(iconTheme: const IconThemeData()),
        child: CurvedNavigationBar(
          key: _navKey,
          height: 60.0,
          color: AppColors.blue1,
          buttonBackgroundColor: AppColors.blue1,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 800),
          items: _buildNavItems(),
          index: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              if (index == 2) hasSeenNotifications = true;
            });
          },
        ),
      ),
    );
  }

  List<Widget> _buildNavItems() {
    return [
      const Icon(Icons.home, size: 30, color: Colors.white),
      const Icon(Icons.add, size: 30, color: Colors.white),
      // TODO: MEJORAR CONTADOR PARA QUE SE REINICIE EL CONTEO CADA QUE EL USUARIO ABRA LA PESTAÑA:
      Stack(
        children: [
          const Icon(Icons.menu_book_rounded, size: 30, color: Colors.white),
          if (globalNotificationCount > 0 && !hasSeenNotifications)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '$globalNotificationCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),

      const Icon(Icons.line_axis, size: 30, color: Colors.white),
      CircleAvatar(
        foregroundImage:
            FirebaseAuth.instance.currentUser?.photoURL != null
                ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                : const NetworkImage(
                  'https://s1.elespanol.com/2019/11/01/elandroidelibre/el_androide_libre_441218515_179632866_1024x576.jpg',
                ),
      ),
    ];
  }
}
