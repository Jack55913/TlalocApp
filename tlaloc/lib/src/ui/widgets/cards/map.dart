import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TlalocMap extends StatelessWidget {
  const TlalocMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ruta de "${Provider.of<AppState>(context).paraje}"'),
          actions: <Widget>[
            Consumer<AppState>(
              builder:
                  (context, state, _) => FutureBuilder<Map<String, dynamic>>(
                    future: state.getCurrentParajeData(),
                    builder: (context, snapshot) {
                      late String url;
                      if (snapshot.hasError) {
                        url = snapshot.error.toString();
                      } else if (snapshot.hasData) {
                        url =
                            snapshot.data?['url'] ??
                            'https://www.youtube.com/watch?v=GJuTIxwQw0k&list=RDGJuTIxwQw0k&start_radio=1';
                      } else {
                        url =
                            'https://www.youtube.com/watch?v=GJuTIxwQw0k&list=RDGJuTIxwQw0k&start_radio=1';
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            launchUrl(Uri.parse(url));
                          },
                          icon: const Icon(Icons.place, color: Colors.red),
                          label: const Text(
                            'Indicaciones',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
            ),
            const SizedBox(width: 15),
            InkWell(
              child: const Icon(Icons.download, color: Colors.green),
              onTap: () {
                launchUrl(
                  Uri.parse(
                    'https://drive.google.com/uc?export=download&id=1hBtVRmEBpqZgFy1LCoh8YlPVJrSVm5yy',
                  ),
                );
              },
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: SfPdfViewer.asset(
          'assets/pdf/mapa.pdf',
          canShowScrollStatus: true,
          canShowScrollHead: true,
          enableDoubleTapZooming: true,
        ),
      ),
    );
  }
}
