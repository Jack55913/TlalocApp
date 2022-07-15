// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_constructors

// import 'dart:html';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/home_widget_classes.dart';
import 'package:tlaloc/page/add.dart';
import 'package:tlaloc/screens/home.dart';
import 'package:tlaloc/widgets/container.dart';
import 'package:tlaloc/widgets/facebook_button.dart';
import 'package:tlaloc/widgets/personal_measures.dart';
import 'package:tlaloc/widgets/tutorials.dart';

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

class Fab extends StatelessWidget {
  const Fab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      tooltip: 'Agregar Medición',
      highlightElevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddScreen()),
        );
      },
      backgroundColor: AppColors.green1,
      icon: const Icon(Icons.add, color: Colors.white),
      mouseCursor: MaterialStateMouseCursor.clickable,
      label: const Text(
        'Agregar',
        style: TextStyle(
          fontFamily: 'poppins',
          fontSize: 18,
          letterSpacing: 2,
          color: Colors.white,
        ),
      ),
    );
  }
}
