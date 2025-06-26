// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_constructors

// import 'dart:html';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton2.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/buttons/fab.dart';
import 'package:tlaloc/src/ui/widgets/buttons/notebook.dart';
import 'package:tlaloc/src/ui/widgets/cards/communitybutton.dart';
import 'package:tlaloc/src/ui/widgets/cards/forms.dart';
import 'package:tlaloc/src/ui/widgets/cards/personal_measures.dart';
import 'package:tlaloc/src/ui/widgets/cards/phrase.dart';
import 'package:tlaloc/src/ui/widgets/cards/tlalocmap.dart';
import 'package:tlaloc/src/ui/widgets/cards/tutorials.dart';
import 'package:tlaloc/src/ui/widgets/info/info_page.dart';
import 'package:tlaloc/src/ui/widgets/objects/quickadd.dart';
import 'package:tlaloc/src/ui/widgets/pluviometer/forecast.dart';
import 'package:tlaloc/src/ui/widgets/pluviometer/header.dart';
import 'package:tlaloc/src/ui/widgets/social/social_media.dart';
// import '../home/home_widget_classes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          title: Row(
            children: [
              Image.asset('assets/images/tlaloc_logo.png', height: 32),
              const SizedBox(width: 8),
              AutoSizeText(
                appName,
                style: TextStyle(
                  fontFamily: 'FredokaOne',
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          actions: const <Widget>[InfoButton2(), FluidDialogWidget()],
        ),
        // drawer: DrawerApp(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;

            final content = [
              OneTimeGoogleButton(message: "Llena el formulario (1 min)"),
              const SizedBox(height: 5),
              QuickAddWidget(),
              const Divider(height: 5, thickness: 4, color: Colors.black),

              
              const TodayWeatherStyleCard(),
              const WeekRainMarker(),
 
              GlassContainer(child: TutorialWidget()),
              GlassContainer(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Tabla de mediciones 📄',
                        style: TextStyle(
                          color: AppColors.blue1,
                          fontFamily: 'FredokaOne',
                          fontSize: 24,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    PersonalMeasures(),
                    GeneralMeasures(),
                  ],
                ),
              ),

              GlassContainer(child: TlalocMapData()),
              Column(
                children: [
                  Center(
                    child: Row(
                      children: const [
                        PhraseCard(),
                        Spacer(), // Espacio entre tarjetas
                        TableButton(),
                      ],
                    ),
                  ),
                  const Divider(height: 20, thickness: 4, color: Colors.black),
                  CommunityButton(),
                  const Divider(height: 20, thickness: 4, color: Colors.black),
                  SocialLinksWidget(),
                  const Divider(height: 20, thickness: 4, color: Colors.black),
                ],
              ),
            ];

            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.forward) {
                  if (!isFabVisable) setState(() => isFabVisable = true);
                } else if (notification.direction == ScrollDirection.reverse) {
                  if (isFabVisable) setState(() => isFabVisable = false);
                }
                return true;
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  alignment: WrapAlignment.center,
                  children:
                      content.map((widget) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                isWide
                                    ? (constraints.maxWidth / 2) - 30
                                    : constraints.maxWidth,
                          ),
                          child: widget,
                        );
                      }).toList(),
                ),
              ),
            );
          },
        ),

        floatingActionButton: Visibility(visible: isFabVisable, child: Fab()),
      ),
    );
  }
}
