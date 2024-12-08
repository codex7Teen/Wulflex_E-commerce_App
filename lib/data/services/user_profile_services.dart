import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wulflex/data/models/user_model.dart';
import 'package:wulflex/core/config/app_constants.dart';

class UserProfileServices {
  final _firestore = FirebaseFirestore.instance;

  //! CREATE USER PROFILE WITH NAME, EMAIL, ETC. IN FIREBASE
  Future<void> createUserProfile(UserModel userModel) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user!.uid;
    await _firestore.collection('users').doc(uid).set(userModel.toMap());
    log('USER PROFILE CREATED IN FIREBASE SUCCESS');
  }

  //! FETCH USER PROFILE
  Future<UserModel?> fetchUserProfile() async {
    // getting user first
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    var uid = user.uid;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      log('USER PROFILE FETCHED FROM FIREBASE SUCCESS');
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  //! UPLOAD IMAGE TO FIREBASE STORAGE
  Future<String?> uploadImage(File image, Function(double) onProgress) async {
    try {
      // Get current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      final storage = FirebaseStorage.instanceFor(bucket: bucket);

      // Format date and time for the filename
      final now = DateTime.now();
      final formattedDate =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final formattedTime =
          '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
      // Create a proper image filename
      final sanitizedDisplayName =
          user.displayName?.replaceAll(RegExp(r'\s+'), '_') ?? 'user';

      final fileName =
          '${sanitizedDisplayName}_${formattedDate}_$formattedTime.jpg';

      // Create storage reference
      final ref = storage.ref('profile_images/$fileName');

      // Upload file
      final uploadingTask = ref.putFile(image);

      // Listen to upload progress
      uploadingTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      });

      final snapshot = await uploadingTask.whenComplete(() => null);

      final urlImageUser = await snapshot.ref.getDownloadURL();
      log('IMAGE UPLOADED AND IMAGE-URL GOT SUCCESSFULLY URL: $urlImageUser');

      return urlImageUser;
    } on FirebaseException catch (e) {
      log('Image Upload error: $e');
      return null;
    }
  }

  //! UPDATE USER PROFILE
  Future<void> updateUser(Map<String, dynamic> updates) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user!.uid;
    await _firestore.collection('users').doc(uid).update(updates);
    log('USER PROFILE UPDATED IN FIREBASE SUCCESS');
  }
}
