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

  //! DELETE USER ACCOUNT
  Future<void> deleteUser() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.delete();
        log("ACCOUNT DELETE SUCCESS");
      }
    } catch (e) {
      log("ERROR DELETING ACCOUNT: $e");
      // Rethrow the error to be caught by the caller
      throw Exception("Failed to delete account: $e");
    }
  }

  //! REAUTHENTICATE ACCOUNT BEFORE DELETION
  Future<void> reauthenticateUser(String email, String password) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Create credentials
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);

        // Reauthenticate
        await user.reauthenticateWithCredential(credential);
        log("REAUTHENTICATION SUCCESS");
      } else {
        throw 'No user is currently signed in.';
      }
    } on FirebaseAuthException catch (e) {
      log("REAUTHENTICATION ERROR: ${e.code}");
      if (e.code == 'wrong-password') {
        handleError('Incorrect password provided for reauthentication.');
      } else if (e.code == 'user-mismatch') {
        handleError(
            'The credentials do not match the currently signed in user.');
      } else if (e.code == 'user-not-found') {
        handleError('No user found for the given email.');
      } else {
        handleError('Reauthentication failed: ${e.message}');
      }
    } catch (e) {
      log("REAUTHENTICATION UNKNOWN ERROR: $e");
      handleError('Error during reauthentication: $e');
    }
  }

//! For Google Sign-In reauthentication
  Future<void> reauthenticateWithGoogle() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Get Google credentials
        final googleUser = await GoogleSignIn().signIn();
        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Reauthenticate
        await user.reauthenticateWithCredential(credential);
        log("GOOGLE REAUTHENTICATION SUCCESS");
      } else {
        throw 'No user is currently signed in.';
      }
    } catch (e) {
      log("GOOGLE REAUTHENTICATION ERROR: $e");
      handleError('Error during Google reauthentication: $e');
    }
  }
}
