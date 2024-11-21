import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/models/user_model.dart';

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

  //! UPDATE USER PROFILE
  Future<void> updateUser(Map<String, dynamic> updates) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user!.uid;
    await _firestore.collection('users').doc(uid).update(updates);
    log('USER PROFILE UPDATED IN FIREBASE SUCCESS');
  }
}
