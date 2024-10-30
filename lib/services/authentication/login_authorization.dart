import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  //! S I G N - U P
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      log('Error: something went wrong $e');
    }
    return null;
  }

  //! L O G - I N
  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      log('Error: something went wrong $e');
    }
    return null;
  }

  //! F O R G O T - P A S S W O R D
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      log("Error: $e");
    }
  }

  //! S I G N - O U T
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('Error: something went wrong $e');
    }
  }
}