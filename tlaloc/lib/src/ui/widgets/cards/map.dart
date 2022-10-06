import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TlalocMap extends StatelessWidget {
  const TlalocMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rutas del Pluviómetro'),
        ),
        body: SfPdfViewer.asset(
          'assets/pdf/mapa.pdf',
        ),
      ),
    );
  }
}
