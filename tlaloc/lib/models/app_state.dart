import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Measurement {
  final String? uploader;
  final int? precipitation;
  final DateTime? dateTime;
  final String id;
  Measurement(
      {this.uploader, this.precipitation, this.dateTime, required this.id});

  factory Measurement.fromJson(Map<String, dynamic> json, String id) {
    Timestamp timestamp = json['time'];
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    return Measurement(
      uploader: json['uploader_name'],
      precipitation: json['precipitation'],
      dateTime: dateTime,
      id: id,
    );
  }
}

class AppState extends ChangeNotifier {
  String ejido = 'Tequexquinahuac';
  bool loading = true;
  final db = FirebaseFirestore.instance;

  AppState() {
    init();
  }

  Future<void> init() async {
    loading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    ejido = prefs.getString('ejido')!;
    loading = false;
    notifyListeners();
  }

  Map<String, dynamic> _getMeasurementJson(
      {required int precipitation, required DateTime time, File? image}) {
    return {
      'precipitation': precipitation,
      'uploader_name': FirebaseAuth.instance.currentUser?.displayName,
      'uploader_email': FirebaseAuth.instance.currentUser?.email,
      'uploader_id': FirebaseAuth.instance.currentUser?.uid,
      'time': time,
    };
  }

  Future<void> addMeasurement(
      {required int precipitation, required DateTime time, File? image}) async {
    /// TODO: imagen
    db.collection('ejidos').doc(ejido).collection('measurements').add(
          _getMeasurementJson(
            precipitation: precipitation,
            time: time,
            image: image,
          ),
        );
  }

  Future<List<Measurement>> getMeasurements() async {
    var event = await db
        .collection('ejidos')
        .doc(ejido)
        .collection('measurements')
        .get();
    final List<Measurement> measurements = [];
    for (var doc in event.docs) {
      measurements.add(Measurement.fromJson(doc.data(), doc.id));
    }
    measurements.sort(
      (a, b) => b.dateTime!.difference(a.dateTime!).inSeconds,
    );
    return measurements;
  }

  Future<void> updateMeasurement({
    required String id,
    required int precipitation,
    required DateTime time,
    File? image,
  }) async {
    await db
        .collection('ejidos')
        .doc(ejido)
        .collection('measurements')
        .doc(id)
        .update(
          _getMeasurementJson(
            precipitation: precipitation,
            time: time,
            image: image,
          ),
        );
  }
}
