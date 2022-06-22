// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/page/home.dart';
import 'package:tlaloc/page/modify_registration.dart';
import 'package:tlaloc/screens/home.dart';
import 'package:tlaloc/widgets/empty_state.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Fab(),
        body: Consumer<AppState>(
          builder: (context, state, _) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: state.getMeasurementsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return EmptyState('Error ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final measurementsSnapshot = snapshot.data!;
                  final measurements =
                      state.getMeasurementsFromSnapshot(measurementsSnapshot);
                  return CustomScrollView(
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
                          background: CachedNetworkImage(
                            imageUrl:
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
                            for (var measurement in measurements)
                              DataWidgetView(measurement: measurement),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

/// TODO: AGRUPAR por fecha. o quizá esté bien así
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
  final Measurement measurement;

  const DataWidgetView({Key? key, required this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ModifyRegistration(measurement: measurement)),
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
                      '  ${measurement.dateTime}',
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
                  '${measurement.precipitation} mm',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Consumer<AppState>(
                  builder: (context, state, child) => Text(
                    state.ejido,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins',
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                if (measurement.uploader != null)
                  CircleAvatar(
                    backgroundColor: AppColors.orange1,
                    radius: 25,
                    child: AutoSizeText(
                      // Iniciales del nombre de quien registró la medición
                      measurement.uploader!.split(' ').map((e) => e[0]).join(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'FredokaOne',
                      ),
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
