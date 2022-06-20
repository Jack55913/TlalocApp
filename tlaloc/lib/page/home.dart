// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/models/home_widget_classes.dart';
import 'package:tlaloc/page/add.dart';
import 'package:tlaloc/screens/navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';



Widget _buildItem(String textTitle, String textsubtitle, String url) {
  return ListTile(
    title: Text(textTitle,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'poppins',
          fontSize: 15,
        )),
    subtitle: Text(
      textsubtitle,
      style: TextStyle(color: Colors.white70),
    ),
    trailing: IconButton(
        color: Colors.white,
        icon: Icon(
          Icons.open_in_new,
        ),
        onPressed: () async {
          launch(url);
        }),
  );
}



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
          title: AutoSizeText('Tláloc App',
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.dark2,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: AutoSizeText(
                          'Realiza éstos pasos',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 229, 131, 1),
                            fontFamily: 'FredokaOne',
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildItem(
                          '🛠️ Realiza tu propio pluviómetro',
                          'Es un instrumento para la medición de lluvia',
                          'https://youtu.be/kDqaTwjJvME'),
                      _buildItem(
                          '⛰️ Instalación',
                          'Coloca tu pluviómetro en un lugar estratégico',
                          'https://youtu.be/qZx-Z3_n4t8'),
                      _buildItem(
                          '📖 Medición de datos',
                          'Revisa los errores comúnes al momento de medir',
                          'https://tlaloc.web.app/'),
                      _buildItem(
                          '🚀 Enviar las mediciones',
                          'Sube los datos obtenidos en la App!',
                          'https://tlaloc-web.web.app/'),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              PhraseCard(),
              Divider(
                height: 20,
                thickness: 1,
              ),
              SizedBox(height: 20),
              DynamicTlalocMap(),
              Divider(
                height: 20,
                thickness: 1,
              ),
              // SizedBox(height: 20),
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
          child: FloatingActionButton(
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
            child: Icon(Icons.add,
                color: Colors.white, semanticLabel: 'Agregar medición'),
          ),
        ),
      ),
    );
  }
}