// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_constructors

// import 'dart:html';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/home_widget_classes.dart';
import 'package:tlaloc/page/drawer.dart';
import 'package:tlaloc/screens/home/kernel.dart';
import 'package:tlaloc/widgets/backgrounds/container.dart';
import 'package:tlaloc/widgets/buttons/fab.dart';
import 'package:tlaloc/widgets/cards/facebook_button.dart';
import 'package:tlaloc/widgets/cards/personal_measures.dart';
import 'package:tlaloc/widgets/cards/tutorials.dart';

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
          title: AutoSizeText(appName,
              style: TextStyle(
                fontFamily: 'FredokaOne',
                fontSize: 24,
                letterSpacing: 2,
              )),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrawerApp()),
              );
            },
          ),
          actions: <Widget>[
            InfoButton(),
            ProfilePage(),
          ],
        ),
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
              DarkContainerWidget(
                data: DarkContainer(
                  fill: TutorialWidget(),
                ),
              ),
              DarkContainerWidget(
                data: DarkContainer(
                  fill: PersonalMeasures(),
                ),
              ),
              PhraseCard(),
              Divider(
                height: 20,
                thickness: 1,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  '¿Cómo llegar al pluviómetro?',
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
              SizedBox(height: 20),
              Divider(
                height: 20,
                thickness: 1,
              ),
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
