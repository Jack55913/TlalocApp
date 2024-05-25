import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton.dart';
import 'package:tlaloc/src/ui/widgets/appbar/profilepage.dart';
import 'package:tlaloc/src/ui/widgets/data_widget.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool isFabVisable = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        // initialIndex: 1,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                title: const Text('Bitácora',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.dark1,
                      fontFamily: 'FredokaOne',
                      fontSize: 24,
                      letterSpacing: 2,
                    )),
                floating: true,
                pinned: true,
                snap: false,
                expandedHeight: 150.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/images/img-7.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                actions: const <Widget>[
                  InfoButton(),
                  ProfilePage(),
                ],
                bottom: const TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: 'Acumulados',
                      icon: Icon(Icons.cloud_outlined),
                    ),
                    // Tab(
                    //   text: 'Reales',
                    //   icon: Icon(Icons.cloud_done_outlined),
                    // ),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: <Widget>[
              // TODO: Quitar my real data
              MyDataWidget(),
              // MyRealDataWidget()
            ],
          ),
        ),
      ),
    );
  }
}
