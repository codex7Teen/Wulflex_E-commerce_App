import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wulflex/core/config/app_constants.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instanceFor(bucket: bucket);

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

  //! DELETING USER DETAILS FROM FIRESTORE AND STORAGE
  Future<void> deleteAllUserDetails() async {
    try {
      // Get current user ID
      final userId = _auth.currentUser!.uid;
      const String adminID = 'administratorIDofwulflex189';

      // First fetch the user document to check for image URL
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data();
      final userImage = userData?['userImage'] as String?;

      // If user has a profile image, delete it from storage
      if (userImage != null && userImage.isNotEmpty) {
        try {
          // Extract the storage path from the URL
          final ref = _storage.refFromURL(userImage);
          await ref.delete();
          log('SERVICES: USER PROFILE IMAGE DELETED SUCCESS');
        } catch (storageError) {
          log('SERVICES: ERROR DELETING PROFILE IMAGE: $storageError');
        }
      }

      // Delete chat room
      try {
        // Construct chat room ID the same way as in ChatServices
        List<String> ids = [adminID, userId];
        ids.sort();
        String chatRoomID = ids.join('_');

        // Get all messages in the chat room
        final messagesSnapshot = await _firestore
            .collection('chat_rooms')
            .doc(chatRoomID)
            .collection('messages')
            .get();

        // Delete all messages
        final batch = _firestore.batch();
        for (var doc in messagesSnapshot.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();

        // Delete the chat room document itself
        await _firestore.collection('chat_rooms').doc(chatRoomID).delete();

        log('SERVICES: CHAT ROOM DELETED SUCCESS');
      } catch (chatError) {
        log('SERVICES: ERROR DELETING CHAT ROOM: $chatError');
        // Continue with other deletions even if chat room deletion fails
      }

      // Delete subcollections using helper
      await _deleteSubcollections('users', userId);

      // Delete the user document from Firestore
      await _firestore.collection('users').doc(userId).delete();
      log('SERVICES: USER DETAILS DELETED SUCCESS');
    } catch (error) {
      log('SERVICES: ERROR DELETING USER DETAILS: $error');
      throw Exception('Failed to delete user details: $error');
    }
  }

  //! Helper function to delete all documents in a subcollection
  Future<void> _deleteSubcollections(String collection, String docId) async {
    try {
      // List of known subcollections
      final subcollections = ['favorites', 'address', 'cart'];

      for (String subcollection in subcollections) {
        final subcollectionRef = _firestore
            .collection(collection)
            .doc(docId)
            .collection(subcollection);

        // Get all documents in the subcollection
        final querySnapshot = await subcollectionRef.get();
        for (var doc in querySnapshot.docs) {
          await subcollectionRef.doc(doc.id).delete();
        }

        log('SERVICES: $subcollection DELETED SUCCESS');
      }
    } catch (e) {
      log('SERVICES: ERROR DELETING SUBCOLLECTIONS: $e');
      throw Exception('Failed to delete subcollections: $e');
    }
  }
}
