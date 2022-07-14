import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Measurement {
  final String? uploader;
  final num? precipitation;
  final DateTime? dateTime;
  final String id;
  final String? imageUrl;
  Measurement(
      {this.uploader,
      this.precipitation,
      this.dateTime,
      required this.id,
      this.imageUrl});

  factory Measurement.fromJson(Map<String, dynamic> json, String id) {
    Timestamp timestamp = json['time'];
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    return Measurement(
      uploader: json['uploader_name'],
      precipitation: json['precipitation'],
      dateTime: dateTime,
      id: id,
      imageUrl: json['image'],
    );
  }
}

class AppState extends ChangeNotifier {
  String paraje = 'Tequexquinahuac';
  bool loading = true;
  final db = FirebaseFirestore.instance;

  AppState() {
    init();
  }

  Future<void> init() async {
    loading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    paraje = prefs.getString('paraje')!;
    loading = false;
    notifyListeners();
  }

  Future<void> changeParaje(String newParaje) async {
    paraje = newParaje;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('paraje', newParaje);
    prefs.setBool('hasFinishedOnboarding', true);
  }

  /// No voy a convertir esto en una clase para que te dé flexibilidad de guardar
  /// lo que quieras en el mismo JSON
  Future<Map<String, dynamic>> getCurrentParajeData() async {
    var ref = db.collection('parajes').doc(paraje);
    var snapshot = await ref.get();
    return snapshot.data() ?? {};
  }

  Future<Map<String, dynamic>> _getMeasurementJson(
      {required num precipitation,
      required DateTime time,
      File? image,
      String? oldImage}) async {
    // Primero, subir imagen a Firebase Hosting
    final auth = FirebaseAuth.instance;
    String? fileUrl;
    if (image != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final String fileExtension = image.path.split('.').last;
      final String fileName =
          '${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second} $precipitation ${auth.currentUser?.email}';
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectionState.none) {
        final imageString = await image.readAsString();
        fileUrl = imageString;
      } else {
        final imageRef =
            storageRef.child("measurements/$fileName.$fileExtension");
        await imageRef.putFile(image);
        fileUrl = await imageRef.getDownloadURL();
      }
    } else if (oldImage != null) {
      fileUrl = oldImage;
    }
    return {
      'precipitation': precipitation,
      'uploader_name': auth.currentUser?.displayName,
      'uploader_email': auth.currentUser?.email,
      'uploader_id': auth.currentUser?.uid,
      'time': time,
      'image': fileUrl,
    };
  }

  Future<void> addMeasurement(
      {required num precipitation, required DateTime time, File? image}) async {
    db.collection('parajes').doc(paraje).collection('measurements').add(
          await _getMeasurementJson(
            precipitation: precipitation,
            time: time,
            image: image,
          ),
        );
  }

  List<Measurement> _getListOfMeasurementsFromDocs(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    final List<Measurement> measurements = [];
    for (var doc in docs) {
      measurements.add(Measurement.fromJson(doc.data(), doc.id));
    }
    measurements.sort(
      (a, b) => b.dateTime!.difference(a.dateTime!).inSeconds,
    );
    return measurements;
  }

  Future<List<Measurement>> getMeasurements() async {
    var event = await db
        .collection('parajes')
        .doc(paraje)
        .collection('measurements')
        .get();
    return _getListOfMeasurementsFromDocs(event.docs);
  }

  List<Measurement> getMeasurementsFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return _getListOfMeasurementsFromDocs(snapshot.docs);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMeasurementsStream() {
    return db
        .collection('parajes')
        .doc(paraje)
        .collection('measurements')
        .snapshots();
  }

  Future<void> updateMeasurement({
    required String id,
    required num precipitation,
    required DateTime time,
    File? image,

    /// En caso de que ya exista un URL de imagen (botón de editar, no crear)
    String? oldImage,
  }) async {
    await db
        .collection('parajes')
        .doc(paraje)
        .collection('measurements')
        .doc(id)
        .update(
          await _getMeasurementJson(
            precipitation: precipitation,
            time: time,
            image: image,
            oldImage: oldImage,
          ),
        );
  }

  Future<void> deleteMeasurement({required String id}) async {
    await db
        .collection('parajes')
        .doc(paraje)
        .collection('measurements')
        .doc(id)
        .delete();
  }
}