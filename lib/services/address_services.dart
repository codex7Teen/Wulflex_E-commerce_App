import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/models/address_model.dart';

class AddressServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Get current user id
  String get _userId => _auth.currentUser!.uid;

  //! ADD ADDRESS
  Future<void> addAddress(AddressModel address) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('address')
          .doc(address.id)
          .set(address.toMap());
    } catch (error) {
      log('SERVICES: Error adding address: $error');
    }
  }

  //! FETCH ADDRESS
  Future<List<AddressModel>> fetchAddress() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('address')
          .get();

      return querySnapshot.docs.map((doc) {
        return AddressModel.fromMap(doc.data(), documentId: doc.id);
      }).toList();
    } catch (error) {
      log('Error fetching cart items: $error');
      return [];
    }
  }

  //! REMOVE ADDRESS
  Future<void> removeAddress(String addressId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('address')
          .doc(addressId)
          .delete();
    } catch (error) {
      log('Failed to delete address: $error');
    }
  }

  //! SAVE SELECTED ADDRESS
  Future<void> saveSelectedAddress(AddressModel address) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .update({'selectedAddressId': address.id});
    } catch (error) {
      log('SERVICES: Error saving selected address: $error');
    }
  }

  //! GET SELECTED ADDRESS
  Future<AddressModel?> getSelectedAddress() async {
    try {
      final userDoc = await _firestore.collection('users').doc(_userId).get();

      final selectedAddressId = userDoc.data()?['selectedAddressId'];

      if (selectedAddressId != null) {
        final addressDoc = await _firestore
            .collection('users')
            .doc(_userId)
            .collection('address')
            .doc(selectedAddressId)
            .get();

        return AddressModel.fromMap(addressDoc.data() ?? {},
            documentId: addressDoc.id);
      }

      return null;
    } catch (error) {
      log('SERVICES: Error getting selected address: $error');
      return null;
    }
  }
}
