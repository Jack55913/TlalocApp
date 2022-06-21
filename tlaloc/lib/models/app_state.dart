import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> addMeasurement(
      {required int precipitation, required DateTime time, File? image}) async {
    /// TODO: imagen
    db.collection('ejidos').doc(ejido).collection('measurements').add({
      'precipitation': precipitation,
      'uploader_name': FirebaseAuth.instance.currentUser?.displayName,
      'uploader_email': FirebaseAuth.instance.currentUser?.email,
      'time': time,
    });
  }
}
