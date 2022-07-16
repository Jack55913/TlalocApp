// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/models/app_state.dart';
import 'package:tlaloc/screens/home/add.dart';

class ModifyRegistration extends StatelessWidget {
  final Measurement measurement;
  const ModifyRegistration({Key? key, required this.measurement})
      : super(key: key);

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
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Editar registro de lluvia',
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddScreen(measurement: measurement),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Eliminar registro',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                          '¿Estás seguro que quieres eliminar este registro?'),
                      content: Text(
                          'No podrás recuperarlo una vez que lo elimines.'),
                      actions: [
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text('Eliminar'),
                          onPressed: () async {
                            try {
                              final state =
                                  Provider.of<AppState>(context, listen: false);
                              await state.deleteMeasurement(id: measurement.id);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Ocurrió un error al eliminar'),
                                  content: Text('$e'),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    barrierDismissible: true,
                  );
                },
              ),
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
                    '${measurement.dateTime!.hour}:${measurement.dateTime!.minute.toString().padLeft(2, '0')}'),
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
                    return _buildDataModify('Paraje:', state.paraje);
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

class ShareResults extends StatelessWidget {
  final Measurement measurement;

  const ShareResults({Key? key, required this.measurement}) : super(key: key);

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
