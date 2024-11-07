import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // For handling errors without the "Exception:" prefix
  void handleError(String errorMessage) {
    log(errorMessage); // Log the error
    throw errorMessage; // Directly throw the string error message
  }

  //! S I G N - U P
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
      // handling errors
    } on FirebaseException catch (e) {
      log('SIGNUP AUTHORISATION ERROR');
      if (e.code == 'email-already-in-use') {
        handleError('Email is already in use.');
      } else if (e.code == 'invalid-email') {
       handleError('Email is not valid');
      } else if (e.code == 'weak-password') {
        handleError('Pasword is weak');
      } else {
        handleError('Sign-Up failed. Please try again.');
      }
    } catch (e) {
      log('SIGNUP UNKNOWN ERROR');
      handleError('Error: Something went wrong');
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
      // handling errors
    } on FirebaseException catch (e) {
      log('LOGIN AUTHORISATION ERROR');
      if (e.code == 'user-not-found') {
        handleError('No account found with this email.');
      } else if (e.code == 'wrong-password') {
        handleError('Incorrect password.');
      } else {
        log('UNKNOWN EXCEPTION $e');
        handleError('Login failed. Incorrect credentials.');
      }
    } catch (e) {
      log('LOGIN UNKNOWN ERROR $e');
      handleError('Error: Something went wrong $e');
    }
    return null;
  }

  //! F O R G O T - P A S S W O R D
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // handling errors
      log("Something went wrong. Error: $e");
      handleError('Something went wrong. Error: $e');
    }
  }

  //! S I G N - O U T
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // handling errors
      log("Something went wrong. Error: $e");
      handleError('Something went wrong. Error: $e ');
    }
  }

  //! G O O G L E - S I G N IN
  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      log("GOOGLE AUTHORISATION ERROR");
      handleError("Error: Something went wrong");
    }
    return null;
  }
}
