import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:file_saver/file_saver.dart';
import 'package:universal_html/html.dart' as universal_html;

extension ExportExcel on AppState {
  Future<void> exportMeasurements(BuildContext context) async {
    try {
      final List<Measurement> data = await getMeasurements();
      final excel = Excel.createExcel();
      final sheet = excel[excel.getDefaultSheet()!];

      // Encabezados
      sheet.appendRow([
        // TextCellValue('ID'),
        TextCellValue('Subido por'),
        // TextCellValue('UID'),
        TextCellValue('Precipitación'),
        TextCellValue('Fecha y hora'),
        TextCellValue('Estado pluviómetro'),
        // TextCellValue('URL imagen'),
        // TextCellValue('URL avatar'),
      ]);

      // Datos
      for (final m in data) {
        sheet.appendRow([
          // TextCellValue(m.id),
          TextCellValue(m.uploader ?? ''),
          // TextCellValue(m.uploaderId ?? ''),
          DoubleCellValue(m.precipitation?.toDouble() ?? 0.0),
          TextCellValue(m.dateTime?.toIso8601String() ?? ''),
          TextCellValue((m.pluviometer ?? false) ? 'Vaciado' : 'No vaciado'),
          // TextCellValue(m.imageUrl ?? ''),
          // TextCellValue(m.avatarUrl ?? ''),
        ]);
      }

      final bytes = excel.save()!;
      final fileName = 'mediciones_${DateTime.now().millisecondsSinceEpoch}.xlsx';

      if (kIsWeb) {
        // Para web
        final blob = universal_html.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        final url = universal_html.Url.createObjectUrlFromBlob(blob);
        final anchor = universal_html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();
        universal_html.Url.revokeObjectUrl(url);
      } else {
        // Para Android/móvil
        if (await _requestStoragePermission(context)) {
          await _saveFileMobile(Uint8List.fromList(bytes), fileName, context);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al exportar: ${e.toString()}')),
      );
    }
  }

  Future<bool> _requestStoragePermission(BuildContext context) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de almacenamiento denegado')),
      );
      return false;
    }
  }

  Future<void> _saveFileMobile(Uint8List bytes, String fileName, BuildContext context) async {
    try {
      // Intenta guardar con file_saver para mejor experiencia de usuario
      try {
        await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          mimeType: MimeType.microsoftExcel,
        );
      } catch (e) {
        // Fallback a path_provider si file_saver falla
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(bytes, flush: true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Archivo guardado en: ${file.path}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar archivo: ${e.toString()}')),
      );
    }
  }
}

extension ExportAllExcel on AppState {
  Future<void> exportAllParajes(BuildContext context) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final QuerySnapshot parajesSnapshot = await firestore
          .collection('roles')
          .doc('Monitor')
          .collection('parajes')
          .get();

      final excel = Excel.createExcel();
      final infoSheet = excel['Parajes'];
      final dataSheet = excel['Mediciones'];

      // 1️⃣ ENCABEZADOS DE LA HOJA DE PARAJES
      infoSheet.appendRow([
        TextCellValue('ID del Paraje'),
        TextCellValue('Nombre del Paraje'),
        TextCellValue('Descripción'),
        TextCellValue('Ubicación'),
        TextCellValue('Total Mediciones'),
        TextCellValue('Última Medición'),
        TextCellValue('Precipitación Acumulada'),
        TextCellValue('URL Imagen'),
      ]);

      // 2️⃣ ENCABEZADOS DE LA HOJA DE MEDICIONES
      dataSheet.appendRow([
        TextCellValue('Paraje'),
        TextCellValue('ID Medición'),
        TextCellValue('Fecha y hora'),
        TextCellValue('Precipitación'),
        TextCellValue('Usuario'),
        TextCellValue('UID'),
        TextCellValue('Estado Pluviómetro'),
      ]);

      // 3️⃣ RECORRER TODOS LOS PARAJES
      for (final doc in parajesSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final parajeName = doc.id;

        // 3.1 Obtener mediciones
        final measurementsSnap = await doc.reference.collection('measurements').get();
        final realMeasurementsSnap = await doc.reference.collection('real_measurements').get();

        double totalPrecipitation = 0;
        DateTime? lastMeasurementDate;

        // 3.2 Recolectar estadísticas para la hoja de parajes
        for (final m in realMeasurementsSnap.docs) {
          final mData = m.data();
          final p = mData['precipitation'] as num? ?? 0;
          totalPrecipitation += p.toDouble();

          final t = mData['time'] as Timestamp?;
          if (t != null) {
            final d = t.toDate();
            if (lastMeasurementDate == null || d.isAfter(lastMeasurementDate)) {
              lastMeasurementDate = d;
            }
          }
        }

        infoSheet.appendRow([
          TextCellValue(parajeName),
          TextCellValue(data['nombre'] ?? 'Sin nombre'),
          TextCellValue(data['descripcion'] ?? 'Sin descripción'),
          TextCellValue(data['ubicacion'] ?? 'Ubicación no especificada'),
          IntCellValue(measurementsSnap.size),
          TextCellValue(lastMeasurementDate?.toIso8601String() ?? 'Sin mediciones'),
          DoubleCellValue(totalPrecipitation),
          TextCellValue(data['imagenUrl'] ?? ''),
        ]);

        // 3.3 Agregar cada medición a la hoja de mediciones
        for (final m in measurementsSnap.docs) {
          final mData = m.data();
          final time = (mData['time'] as Timestamp?)?.toDate().toIso8601String() ?? '';
          final precipitation = (mData['precipitation'] as num?)?.toDouble() ?? 0.0;
          final uploader = mData['uploader_name'] ?? '';
          final uploaderId = mData['uploader_id'] ?? '';
          final pluvio = (mData['pluviometer_state'] ?? false) == true ? 'Vaciado' : 'No vaciado';

          dataSheet.appendRow([
            TextCellValue(parajeName),
            TextCellValue(m.id),
            TextCellValue(time),
            DoubleCellValue(precipitation),
            TextCellValue(uploader),
            TextCellValue(uploaderId),
            TextCellValue(pluvio),
          ]);
        }
      }

      final bytes = excel.save()!;
      final fileName = 'parajes_y_mediciones_${DateTime.now().millisecondsSinceEpoch}.xlsx';

      if (kIsWeb) {
        // Para web
        final blob = universal_html.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        final url = universal_html.Url.createObjectUrlFromBlob(blob);
        final anchor = universal_html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();
        universal_html.Url.revokeObjectUrl(url);
      } else {
        // Para Android/móvil
        if (await _requestStoragePermission(context)) {
          await _saveFileMobile(Uint8List.fromList(bytes), fileName, context);
        }
      }
    } catch (e) {
      debugPrint('Error en exportAllParajes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al exportar: ${e.toString()}')),
      );
    }
  }
}