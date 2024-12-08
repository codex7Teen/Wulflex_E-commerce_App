import 'package:firebase_core/firebase_core.dart';

//! FIREBASE STORAGE BUCKET NAME
const String bucket = 'wulflex.firebasestorage.app';

//! FIREBASE OPTIONS
class FirebaseConfig {
  static const String bucket = 'wulflex.firebasestorage.app';
  static const String apiKey = "AIzaSyDMzuQfFMY4pScI7ihyfVFV5fsT0pcsATI";
  static const String authDomain = "wulflex.firebaseapp.com";
  static const String projectId = "wulflex";
  static const String storageBucket = "wulflex.appspot.com";
  static const String messagingSenderId = "57079492115";
  static const String appId = "1:57079492115:web:4366c95936974dda3fd9e6";

  static FirebaseOptions get firebaseOptions => FirebaseOptions(
        apiKey: apiKey,
        authDomain: authDomain,
        projectId: projectId,
        storageBucket: storageBucket,
        messagingSenderId: messagingSenderId,
        appId: appId,
      );
}
