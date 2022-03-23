// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/page/modify_registration.dart';
import 'package:tlaloc/screens/navigation_bar.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Diario',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                      fontSize: 24,
                      letterSpacing: 2,
                    )),
              ),
              actions: <Widget>[
                InfoButton(),
                ProfilePage(),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  RegisterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ayer',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'poppins',
              )),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.white38,
          ),
          DataWidgetView(),
        ],
      ),
    );
  }
}

class DataWidgetView extends StatelessWidget {
  const DataWidgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ModifyRegistration()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: AppColors.green1,
                      size: 14,
                    ),
                    Text(
                      '  12:58',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                //Agregar espacio
                SizedBox(height: 5),
                Text(
                  '10 ml',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tequexquinahuac',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // Crear círculo con una imágen de internet
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://proyecto-miyotl.web.app/images/icon-full.png'),
                  radius: 25,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
