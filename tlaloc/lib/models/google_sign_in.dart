import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  static const String _webSign =
      '228815382617-2rtslpepg048j80iuls7ilrc8ff9sn4l.apps.googleusercontent.com';
  static final googleSignIn = GoogleSignIn(
    clientId: _webSign,
  );

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get recentlySignedInUser => _user;

  final user = FirebaseAuth.instance.currentUser;

  Future<void> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
