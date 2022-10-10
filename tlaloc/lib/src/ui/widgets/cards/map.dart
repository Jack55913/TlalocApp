import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TlalocMap extends StatelessWidget {
  const TlalocMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: SelectableText(
              'Ruta de "${Provider.of<AppState>(context).paraje}"'),
          actions: <Widget>[
            InkWell(
              child: const Icon(Icons.picture_as_pdf, color: Colors.blue),
              onTap: () {
                launchUrl(
                  Uri.parse(
                      'https://drive.google.com/file/d/1FMi8epSV6S5G3lN6tDDD20oGPLAvADmq/view?usp=sharing'),
                );
              },
            ),
            const SizedBox(
              width: 15,
            ),
            Consumer<AppState>(
              builder: (context, state, _) =>
                  FutureBuilder<Map<String, dynamic>>(
                      future: state.getCurrentParajeData(),
                      builder: (context, snapshot) {
                        late String url;
                        if (snapshot.hasError) {
                          url = snapshot.error.toString();
                        } else if (snapshot.hasData) {
                          url = snapshot.data?['url'] ??
                              'https://www.youtube.com/watch?v=GJuTIxwQw0k&list=RDGJuTIxwQw0k&start_radio=1';
                        } else {
                          url =
                              'https://www.youtube.com/watch?v=GJuTIxwQw0k&list=RDGJuTIxwQw0k&start_radio=1';
                        }
                        return InkWell(
                          child: const Icon(Icons.place, color: Colors.red),
                          onTap: () {
                            launchUrl(
                              Uri.parse(url),
                            );
                          },
                        );
                      }),
            ),
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
