// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/page/add.dart';

class ModifyRegistration extends StatelessWidget {
  final Measurement measurement;
  ModifyRegistration({Key? key, required this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: AutoSizeText('Modificar',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'FredokaOne',
                  fontSize: 24,
                  letterSpacing: 2,
                )),
            actions: <Widget>[
              const EditButton(),
              ShareResults(measurement: measurement),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text('Registro de Lluvia:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FredokaOne',
                    )),
                SizedBox(height: 15),
                _buildDataModify(
                    'Precipitación', '${measurement.precipitation} mm'),
                SizedBox(height: 15),
                _buildDataModify(
                    '${measurement.dateTime!.day}/${measurement.dateTime!.month}/${measurement.dateTime!.day}',
                    '${measurement.dateTime!.hour}:${measurement.dateTime!.minute}'),
                SizedBox(height: 5),
                Divider(
                  height: 20,
                  thickness: 1,
                ),
                SizedBox(height: 15),
                Text('Datos generales',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FredokaOne',
                    )),
                SizedBox(height: 15),
                _buildDataModify('Autor:', '${measurement.uploader}'),
                SizedBox(height: 15),
                Consumer<AppState>(
                  builder: (context, state, child) {
                    return _buildDataModify('Ejido:', state.ejido);
                  },
                ),
                if (measurement.imageUrl != null) ...[
                  SizedBox(height: 5),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Fotografía',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FredokaOne',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CachedNetworkImage(
                      imageUrl: measurement.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]
              ],
            ),
          )),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: 'Editar registro de lluvia',
      onPressed: () {
        Navigator.push(
          context,

          /// TODO: this takes you to the add screen, edit this to allow editing
          MaterialPageRoute(builder: (context) => const AddScreen()),
        );
      },
    );
  }
}

class ShareResults extends StatelessWidget {
  final Measurement measurement;

  ShareResults({Key? key, required this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      tooltip: 'Compartir registro de lluvia',
      onPressed: () {
        Share.share(
            '¡Mira! *${measurement.dateTime} llovió ${measurement.precipitation} mm*. Ayúdame a medir, descargándo la app en tlaloc.web.app');
      },
    );
  }
}

Widget _buildDataModify(String textTitle, String textsubtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(textTitle,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'poppins',
          )),
      Text(textsubtitle,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'poppins',
          )),
    ],
  );
}
