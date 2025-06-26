import 'package:flutter/foundation.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId: kIsWeb 
        ? '228815382617-2rtslpepg048j80iuls7ilrc8ff9sn4l.apps.googleusercontent.com'
        : null, // Para Android/iOS, Firebase maneja automáticamente el Client ID
  );

  User? get currentUser => _auth.currentUser;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> googleLogin() async {
    try {
      _isLoading = true;
      notifyListeners();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      debugPrint('Error inesperado: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut(); // Mejor que disconnect()
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error al cerrar sesión: $e');
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    debugPrint('Código de error: ${e.code}');
    String message = 'Error de autenticación';

    switch (e.code) {
      case 'account-exists-with-different-credential':
        message = 'Cuenta ya existe con otro método de autenticación';
        break;
      case 'invalid-credential':
        message = 'Credenciales inválidas';
        break;
      case 'operation-not-allowed':
        message = 'Método de autenticación no habilitado';
        break;
      case 'user-disabled':
        message = 'Cuenta deshabilitada';
        break;
      case 'user-not-found':
        message = 'Usuario no encontrado';
        break;
    }

    throw AuthException(message);
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => message;
}