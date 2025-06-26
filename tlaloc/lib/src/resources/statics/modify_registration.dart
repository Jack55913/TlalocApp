// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/resources/statics/graphs/graph_today.dart';
import 'package:tlaloc/src/ui/screens/dir/add.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton2.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';

class ModifyRegistration extends StatelessWidget {
  final Measurement measurement;
  final bool isEmbedded;

  const ModifyRegistration({
    super.key,
    required this.measurement,
    this.isEmbedded = false,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final isOwner = currentUserId == measurement.uploaderId;

    // Contenido principal, sin Scaffold ni SafeArea
    final content = Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                'Precipitación',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontFamily: 'FredokaOne'),
              ),
              Spacer(),
              InfoButton2(),
            ],
          ),
          Text(
            'Total del día:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontFamily: 'poppins'),
          ),
          GlassContainer(child: DayBarChart(day: measurement.dateTime!)),
          SizedBox(height: 15),
          // Título
          Text(
            'Registro de Lluvia:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 24, fontFamily: 'FredokaOne'),
          ),
          SizedBox(height: 15),
          _buildDataModify(
            'Precipitación:',
            '${measurement.precipitation} mm',
            Icon(Icons.circle, color: Colors.blue),
          ),
          SizedBox(height: 15),
          _buildDataModify(
            'Fecha: ${measurement.dateTime!.day}/${measurement.dateTime!.month}/${measurement.dateTime!.year}',
            '${measurement.dateTime!.hour}:${measurement.dateTime!.minute.toString().padLeft(2, '0')}',
            Icon(Icons.timer, color: Colors.grey),
          ),
          SizedBox(height: 15),
          _buildDataModify(
            'Vació el Pluviómetro:',
            '${measurement.pluviometer}',
            Icon(Icons.water_drop, color: Colors.grey),
          ),
          SizedBox(height: 5),
          Divider(height: 10, thickness: 4, color: Colors.black),
          SizedBox(height: 15),
          Text(
            'Datos generales',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 24, fontFamily: 'FredokaOne'),
          ),
          SizedBox(height: 15),
          _buildDataModify(
            'Autor:',
            '${measurement.uploader}',
            Icon(Icons.person, color: Colors.grey),
          ),
          SizedBox(height: 15),
          Consumer<AppState>(
            builder: (context, state, child) {
              return _buildDataModify(
                'Paraje:',
                state.paraje,
                Icon(Icons.place, color: Colors.grey),
              );
            },
          ),
          SizedBox(height: 15),
          // Consumer<AppState>(
          //   builder: (context, state, child) {
          //     return _buildDataModify(
          //       'Rol:',
          //       state.rol,
          //       Icon(Icons.rocket_launch, color: Colors.grey),
          //     );
          //   },
          // ),
          // Divider(height: 10, thickness: 4, color: Colors.black),
          // SizedBox(height: 15),
          // Text(
          //   'Fotografía',
          //   textAlign: TextAlign.left,
          //   style: TextStyle(fontSize: 24, fontFamily: 'FredokaOne'),
          // ),
          // SizedBox(height: 15),
          // Divider(height: 10, thickness: 4, color: Colors.black),
          // if (measurement.imageUrl != null &&
          //     measurement.imageUrl!.isNotEmpty) ...[
          //   const SizedBox(height: 5),
          //   const Divider(height: 20, thickness: 1),
          //   const SizedBox(height: 15),
          //   const Text(
          //     'Fotografía',
          //     textAlign: TextAlign.left,
          //     style: TextStyle(fontSize: 24, fontFamily: 'FredokaOne'),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.1),
          //             blurRadius: 6,
          //             offset: const Offset(0, 3),
          //           ),
          //         ],
          //       ),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(12),
          //         child: CachedNetworkImage(
          //           imageUrl: measurement.imageUrl!,
          //           fit: BoxFit.cover,
          //           width: double.infinity,
          //           height: 250,
          //           placeholder:
          //               (context, url) => Container(
          //                 color: Colors.grey[200],
          //                 child: const Center(
          //                   child: CircularProgressIndicator(),
          //                 ),
          //               ),
          //           errorWidget:
          //               (context, url, error) => Container(
          //                 color: Colors.grey[200],
          //                 child: const Center(
          //                   child: Icon(Icons.error, color: Colors.red),
          //                 ),
          //               ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );

    if (isEmbedded) {
      // Retorna solo el contenido para que sea embebido en pantallas más amplias
      return content;
    }

    // En pantalla completa retorna con Scaffold y AppBar
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            'Medición',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          actions: [
            if (isOwner)
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
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
            if (isOwner)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red[300]),
                tooltip: 'Eliminar registro',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(
                            '¿Estás seguro que quieres eliminar este registro?',
                          ),
                          content: Text(
                            'No podrás recuperarlo una vez que lo elimines.',
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: Text('Eliminar'),
                              onPressed: () async {
                                try {
                                  final state = Provider.of<AppState>(
                                    context,
                                    listen: false,
                                  );
                                  await state.deleteMeasurement(
                                    id: measurement.id,
                                  );
                                  await state.deleteRealMeasurement(
                                    id: measurement.id,
                                  );
                                  Navigator.of(
                                    context,
                                  ).pop(); // Cierra confirmación
                                  Navigator.of(context).pop(); // Vuelve atrás
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text(
                                            'Ocurrió un error al eliminar',
                                          ),
                                          content: Text('$e'),
                                        ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                  );
                },
              ),
            ShareResults(measurement: measurement),
          ],
        ),
        body: content,
      ),
    );
  }
}

class ShareResults extends StatelessWidget {
  final Measurement measurement;

  const ShareResults({super.key, required this.measurement});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      tooltip: 'Compartir registro de lluvia',
      onPressed: () {
        Share.share(
          '¡Mira! *${measurement.dateTime} llovió ${measurement.precipitation} mm*. Ayúdame a medir, descargándo la app en tlaloc.web.app',
        );
      },
    );
  }
}

Widget _buildDataModify(String textTitle, String textsubtitle, Icon icon) {
  return GlassContainer(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            SizedBox(width: 10),
            Text(
              textTitle,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'poppins',
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Text(
          textsubtitle,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    ),
  );
}
