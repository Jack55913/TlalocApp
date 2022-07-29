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
  final String? avatarUrl; //+
  Measurement({
    this.uploader,
    this.precipitation,
    this.dateTime,
    required this.id,
    this.imageUrl,
    this.avatarUrl, //+
  });
  factory Measurement.fromJson(Map<String, dynamic> json, String id) {
    Timestamp timestamp = json['time'];
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    // Timestamp formatTime = json['short_time'];
    // var formattedDate = DateFormat('MM-dd-yyyy HH:mm').format(formatTime.toDate());

    return Measurement(
      // formatTime: formattedDate,
      uploader: json['uploader_name'],
      precipitation: json['precipitation'],
      dateTime: dateTime,
      id: id,
      imageUrl: json['image'],
      avatarUrl: json['avatar_url'], //+
    );
  }
}

class AppState extends ChangeNotifier {
  String rol = 'Visitante';
  String paraje = 'Cabaña'; //+
  // String formatTime = 'MM-dd-yyyy HH:mm';
  bool loading = true;
  final db = FirebaseFirestore.instance;

  AppState() {
    init();
  }

  Future<void> init() async {
    loading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    rol = prefs.getString('rol')!; //+
    paraje = prefs.getString('paraje')!;
    loading = false;
    notifyListeners();
  }

// Para cambiar de Rol y Paraje se realizan las siguientes dos funciones:

  Future<void> changeParaje(String newParaje) async {
    paraje = newParaje;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('paraje', newParaje);
    prefs.setBool('hasFinishedOnboarding', true);
  }

  Future<void> changeRol(String newRol) async {
    rol = newRol;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('rol', newRol);
    prefs.setBool('hasFinishedOnboarding', true);
  }

// PARA OBTENER LOS DATOS DE "ÍNDICE GEOGRÁFICO":

  Future<Map<String, dynamic>> getCurrentParajeData() async {
    var ref = db.collection('roles').doc(rol).collection('parajes').doc(paraje);
    var snapshot = await ref.get();
    return snapshot.data() ?? {};
  }

// PARA GUARDAR LAS FOTOS EN FIREBASE STORAGE:

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
        // Se crea una carpeta con el nombre measurement:
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
      'avatar_url': auth.currentUser?.photoURL,//+
    };
  }

  Future<void> addMeasurement(
      {required num precipitation, required DateTime time, File? image}) async {
    db
        .collection('roles')
        .doc(rol)
        .collection('parajes')
        .doc(paraje)
        .collection('measurements')
        .add(
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
        .collection('roles')
        .doc(rol)
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
        .collection('roles')
        .doc(rol)
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
        .collection('roles')
        .doc(rol)
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
        .collection('roles')
        .doc(rol)
        .collection('parajes')
        .doc(paraje)
        .collection('measurements')
        .doc(id)
        .delete();
  }
}