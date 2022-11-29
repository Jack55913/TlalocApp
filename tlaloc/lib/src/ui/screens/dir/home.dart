// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_constructors

// import 'dart:html';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/appbar/drawer.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/buttons/fab.dart';
import 'package:tlaloc/src/ui/widgets/buttons/notebook.dart';
import 'package:tlaloc/src/ui/widgets/cards/phrase.dart';
import 'package:tlaloc/src/ui/widgets/cards/tutorials.dart';
import 'package:tlaloc/src/ui/widgets/objects/quickadd.dart';
import '../home/home_widget_classes.dart';
import '../../widgets/appbar/infobutton.dart';
import '../../widgets/appbar/profilepage.dart';
import '../../widgets/cards/facebook_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFabVisable = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            appName,
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          actions: const <Widget>[
            InfoButton(),
            ProfilePage(),
          ],
        ),
        drawer: DrawerApp(),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!isFabVisable) setState(() => isFabVisable = true);
            } else if (notification.direction == ScrollDirection.reverse) {
              if (isFabVisable) setState(() => isFabVisable = false);
            }
            return true;
          },
          child: ListView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            children: [
              QuickAddWidget(),
              Divider(
                thickness: 1,
              ),
              DarkContainerWidget(
                data: DarkContainer(
                  fill: TutorialWidget(),
                ),
              ),
              // DarkContainerWidget(
              //   data: DarkContainer(
              //     fill: PersonalMeasures(),
              //   ),
              // ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PhraseCard(),
                    DarkContainerWidget(
                      data: DarkContainer(
                        fill: TableButton(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              // SizedBox(height: 20),

              SizedBox(height: 20),
              Center(
                child: SelectableText(
                  '📍¿Cómo llegar a "${Provider.of<AppState>(context).paraje}"?',
                  style: TextStyle(
                    fontFamily: 'FredokaOne',
                    fontSize: 24,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              DynamicTlalocMap(),
              SizedBox(height: 10),
              FacebookButton(),
              Divider(
                height: 20,
                thickness: 1,
              ),
              ContactUsButton(),
              Divider(
                height: 20,
                thickness: 1,
              ),
              SizedBox(height: 20),
              // GoogleAddWidget(),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: isFabVisable,
          child: Fab(),
        ),
      ),
    );
  }
}
