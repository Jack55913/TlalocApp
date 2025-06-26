import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tlaloc/src/models/google_sign_in.dart';

class Measurement {
  final String? uploader;
  final double? precipitation;
  final DateTime? dateTime;
  final String id;
  final String? imageUrl;
  final String? avatarUrl;
  final String? uploaderId;
  final bool? pluviometer;

  Measurement({
    this.uploader,
    this.uploaderId,
    this.precipitation,
    this.dateTime,
    required this.id,
    this.imageUrl,
    this.avatarUrl,
    this.pluviometer,
  });

  factory Measurement.fromJson(Map<String, dynamic> json, String id) {
    Timestamp timestamp = json['time'];
    return Measurement(
      uploader: json['uploader_name'],
      uploaderId: json['uploader_id'] as String? ?? 'unknown',
      precipitation: (json['precipitation'] as num?)?.toDouble(),

      dateTime: timestamp.toDate(),
      id: id,
      imageUrl: json['image'],
      avatarUrl: json['avatar_url'],
      pluviometer: json['pluviometer_state'],
    );
  }
}

class AppState extends ChangeNotifier {
  Uint8List? _newWebImage;
  Uint8List? get newWebImage => _newWebImage;
  set newWebImage(Uint8List? value) {
    _newWebImage = value;
    notifyListeners(); // si quieres que se reconstruyan widgets
  }

  final GoogleSignInProvider _authProvider;
  final db = FirebaseFirestore.instance;

  AppState(this._authProvider) {
    init();
  }

  String rol = 'Monitor';
  String paraje = 'El Venturero';
  bool loading = true;
  List<String> adminUIDs = [];
  bool isAdmin = false;

  User? get currentUser => _authProvider.currentUser;
  String? get currentUID => currentUser?.uid;

  DocumentReference get _parajeRef =>
      db.collection('roles').doc(rol).collection('parajes').doc(paraje);
  CollectionReference get _measurementsRef =>
      _parajeRef.collection('measurements');
  CollectionReference get _realMeasurementsRef =>
      _parajeRef.collection('real_measurements');

  Future<void> init() async {
    loading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    rol = prefs.getString('rol') ?? 'Monitor';
    paraje = prefs.getString('paraje') ?? 'El Venturero';

    await _loadAdminUIDs();
    _checkAdminStatus();

    loading = false;
    notifyListeners();
  }

  Future<void> _loadAdminUIDs() async {
    try {
      final doc = await db.collection('admins').doc('adminUsers').get();
      if (doc.exists) {
        adminUIDs = List<String>.from(doc.data()?['uids'] ?? []);
      }
    } catch (e) {
      debugPrint("Error cargando admins: $e");
    }
  }

  void _checkAdminStatus() {
    isAdmin = currentUID != null && adminUIDs.contains(currentUID);
  }

  bool canEditMeasurement(String? uploaderId) =>
      currentUID == uploaderId || isAdmin;

  Future<void> changeParaje(String newParaje) async {
    paraje = newParaje;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('paraje', newParaje);
    prefs.setBool('hasFinishedOnboarding', true);
    notifyListeners();
  }

  Future<void> changeRol(String newRol) async {
    rol = newRol;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('rol', newRol);
    prefs.setBool('hasFinishedOnboarding', true);
    notifyListeners();
  }

  Future<Map<String, dynamic>> getCurrentParajeData() async {
    var snapshot = await _parajeRef.get();
    return (snapshot.data() as Map<String, dynamic>?) ?? {};
  }

  Future<String?> _uploadImage(
    String fileNameBase, {
    File? image,
    String? oldImage,
  }) async {
    final storageRef = FirebaseStorage.instance.ref();
    final connectivityResult = await Connectivity().checkConnectivity();

    if (kIsWeb && newWebImage != null) {
      if (connectivityResult != ConnectivityResult.none) {
        final imageRef = storageRef.child("measurements/$fileNameBase.png");
        final metadata = SettableMetadata(contentType: 'image/png');
        await imageRef.putData(newWebImage!, metadata);
        return await imageRef.getDownloadURL();
      } else {
        return base64Encode(newWebImage!);
      }
    } else if (image != null) {
      if (connectivityResult != ConnectivityResult.none) {
        final extension = image.path.split('.').last;
        final imageRef = storageRef.child(
          "measurements/$fileNameBase.$extension",
        );
        await imageRef.putFile(image);
        return await imageRef.getDownloadURL();
      } else {
        return await image.readAsString();
      }
    }

    return oldImage;
  }

  Future<Map<String, dynamic>> _getMeasurementJson({
    required num precipitation,
    required DateTime time,
    String? uploader,
    File? image,
    String? oldImage,
    bool? pluviometer,
  }) async {
    final fileNameBase =
        '${time.toIso8601String()}_$precipitation${currentUser?.email}';
    final imageUrl = await _uploadImage(
      fileNameBase,
      image: image,
      oldImage: oldImage,
    );

    return {
      'uploader_id': currentUID,
      'precipitation': precipitation,
      'uploader_name': uploader,
      'uploader_email': currentUser?.email,
      'time': time,
      'image': imageUrl,
      'avatar_url': currentUser?.photoURL,
      'pluviometer_state': pluviometer,
    };
  }

  Future<void> _saveMeasurement(
    String collectionName,
    Map<String, dynamic> data,
  ) async {
    await _parajeRef.collection(collectionName).add(data);
  }

  Future<num> _calculateRealValue(num current, bool? wasEmptied) async {
    final lastSnapshot =
        await _measurementsRef.orderBy('time', descending: true).limit(2).get();

    if (lastSnapshot.docs.length < 2 || wasEmptied == true) {
      return current;
    } else {
      final prevData = lastSnapshot.docs[1].data() as Map<String, dynamic>;
      final prevPrecip = prevData['precipitation'] as num? ?? 0;
      return current - prevPrecip;
    }
  }

  Future<void> updateGlobalCounter(int delta) async {
    final counterRef = db.collection('notifications').doc('globalCounter');
    await counterRef.set({
      'count': FieldValue.increment(delta),
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> addMeasurement({
    required num precipitation,
    required DateTime time,
    String? uploader,
    File? image,
    bool? pluviometer,
  }) async {
    final data = await _getMeasurementJson(
      uploader: uploader,
      precipitation: precipitation,
      time: time,
      image: image,
      pluviometer: pluviometer,
    );
    await _saveMeasurement('measurements', data);

    final realValue = await _calculateRealValue(precipitation, pluviometer);
    final realData = await _getMeasurementJson(
      uploader: uploader,
      precipitation: realValue,
      time: time,
      image: image,
      pluviometer: pluviometer,
    );
    await _saveMeasurement('real_measurements', realData);

    await updateGlobalCounter(1);
  }

  Future<void> addRealMeasurement({
    required num precipitation,
    required DateTime time,
    num lastPrecipitation = 0,
    String? uploader,
    File? image,
    bool? pluviometer,
  }) async {
    final data = await _getMeasurementJson(
      uploader: uploader,
      precipitation: precipitation - lastPrecipitation,
      time: time,
      image: image,
      pluviometer: pluviometer,
    );
    await _saveMeasurement('real_measurements', data);
  }

  List<Measurement> getMeasurementsFromDocs(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final measurements =
        docs.map((doc) => Measurement.fromJson(doc.data(), doc.id)).toList();
    measurements.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
    return measurements;
  }

  Future<List<Measurement>> getMeasurements() async => getMeasurementsFromDocs(
    (await _measurementsRef.get() as QuerySnapshot<Map<String, dynamic>>).docs,
  );

  Future<List<Measurement>> getRealMeasurements() async =>
      getMeasurementsFromDocs(
        (await _realMeasurementsRef.get()
                as QuerySnapshot<Map<String, dynamic>>)
            .docs,
      );

  Stream<QuerySnapshot<Map<String, dynamic>>> _measurementStream(
    String collection, {
    String? parajeOverride,
  }) {
    final ref = db
        .collection('roles')
        .doc('Monitor')
        .collection('parajes')
        .doc(parajeOverride ?? paraje)
        .collection(collection);
    return ref.orderBy('time', descending: false).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMeasurementsStream() =>
      _measurementStream('measurements');

  Stream<QuerySnapshot<Map<String, dynamic>>> getRealMeasurementsStream() =>
      _measurementStream('real_measurements');

  Stream<QuerySnapshot<Map<String, dynamic>>> getMeasurementsStreamForParaje(
    String name,
  ) => _measurementStream('measurements', parajeOverride: name);

  Stream<QuerySnapshot<Map<String, dynamic>>>
  getRealMeasurementsStreamForParaje(String name) =>
      _measurementStream('real_measurements', parajeOverride: name);

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserMeasurementsStream() {
    if (currentUID == null) return const Stream.empty();
    return db
        .collectionGroup('measurements')
        .where('uploader_id', isEqualTo: currentUID)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMeasurementsStream() =>
      db.collectionGroup('measurements').snapshots();

  Future<void> updateMeasurement({
    required String id,
    required num precipitation,
    required DateTime time,
    String? uploader,
    File? image,
    bool? pluviometer,
    String? oldImage,
    required String uploaderId,
  }) async {
    if (!canEditMeasurement(uploaderId)) {
      throw Exception("No tiene permisos para editar esta medición");
    }
    final data = await _getMeasurementJson(
      uploader: uploader,
      precipitation: precipitation,
      time: time,
      image: image,
      oldImage: oldImage,
      pluviometer: pluviometer,
    );
    await _measurementsRef.doc(id).update(data);
  }

  Future<void> updateRealMeasurement({
    required String id,
    required num precipitation,
    required DateTime time,
    String? uploader,
    File? image,
    bool? pluviometer,
    String? oldImage,
  }) async {
    final data = await _getMeasurementJson(
      uploader: uploader,
      precipitation: precipitation,
      time: time,
      image: image,
      oldImage: oldImage,
      pluviometer: pluviometer,
    );
    await _realMeasurementsRef.doc(id).update(data);
  }

  Future<void> deleteMeasurement({required String id}) async {
    try {
      await _measurementsRef.doc(id).delete();
      // await updateGlobalCounter(-1);
    } catch (e) {
      debugPrint("Error al borrar medición: $e");
    }
  }

  Future<void> deleteRealMeasurement({required String id}) async {
    try {
      await _realMeasurementsRef.doc(id).delete();
      // await updateGlobalCounter(-1);
    } catch (e) {
      debugPrint("Error al borrar medición real: $e");
    }
  }

  Future<Map<String, dynamic>> getUserStats() async {
    try {
      if (currentUID == null) {
        return {
          'local': 0,
          'global': 0,
          'distinctParajes': 0,
          'totalParajes': 0,
        };
      }

      final localSnapshot = await _measurementsRef
          .where('uploader_id', isEqualTo: currentUID)
          .get(const GetOptions(source: Source.serverAndCache));

      final globalSnapshot = await db
          .collectionGroup('measurements')
          .where('uploader_id', isEqualTo: currentUID)
          .get(const GetOptions(source: Source.serverAndCache));

      final parajesContribuidos = <String>{};
      for (final doc in globalSnapshot.docs) {
        final segments = doc.reference.path.split('/');
        final parajeName =
            segments.contains('parajes')
                ? segments[segments.indexOf('parajes') + 1]
                : null;
        if (parajeName != null) parajesContribuidos.add(parajeName);
      }

      final totalParajesSnapshot = await db
          .collection('roles')
          .doc(rol)
          .collection('parajes')
          .get(const GetOptions(source: Source.serverAndCache));

      return {
        'local': localSnapshot.docs.length,
        'global': globalSnapshot.docs.length,
        'distinctParajes': parajesContribuidos.length,
        'totalParajes': totalParajesSnapshot.docs.length,
      };
    } catch (e) {
      debugPrint("Error en getUserStats: $e");
      return {
        'local': 0,
        'global': 0,
        'distinctParajes': 0,
        'totalParajes': 0,
        'error': e.toString(),
      };
    }
  }
}
