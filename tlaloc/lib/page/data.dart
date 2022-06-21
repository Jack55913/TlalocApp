// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/page/home.dart';
import 'package:tlaloc/page/modify_registration.dart';
import 'package:tlaloc/screens/home.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Diario',
                    style: TextStyle(
                      // color: Colors.black,
                      fontFamily: 'FredokaOne',
                      fontSize: 24,
                      letterSpacing: 2,
                    )),
                background: Image.network(
                  'https://i0.wp.com/mas-mexico.com.mx/wp-content/uploads/2019/09/popurri-de-viajes.jpg?resize=770%2C330&ssl=1',
                  fit: BoxFit.cover,
                ),
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
                  DataWidgetView(),
                  DataWidgetView(),
                  DataWidgetView(),
                  RegisterWidget(),
                  DataWidgetView(),
                  DataWidgetView(),
                  RegisterWidget(),
                  DataWidgetView(),
                  DataWidgetView(),
                  DataWidgetView(),
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
          ),
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
                      color: Colors.grey,
                      size: 14,
                    ),
                    Text(
                      '  12:58',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '10 ml',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
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
                  backgroundColor: AppColors.orange1,
                  radius: 25,
                  child: Icon(
                    FontAwesomeIcons.t,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
