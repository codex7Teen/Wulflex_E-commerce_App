import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/data/models/message_model.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //! SEND A MESSAGE TO ADMIN
  Future<void> sendMessage(message) async {
    // Get  reciever info (admin)
    const String adminID = 'administratorIDofwulflex189';
    final Timestamp timestamp = Timestamp.now();
    // Get sender info (user)
    final userID = _auth.currentUser!.uid;
    final userEmail = _auth.currentUser!.email;

    // create a new message
    MessageModel newMessage = MessageModel(
        senderID: userID,
        senderEmail: userEmail!,
        recieverID: adminID,
        message: message,
        timestamp: timestamp);

    // construct chat room ID for storing message
    List<String> ids = [adminID, userID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
    log('SERVICES: MESSAGE SENT SUCCESS');
  }

  //! GET MESSAGES
  Stream<QuerySnapshot> getMessages() {
    // Get  reciever info (admin)
    const String adminID = 'administratorIDofwulflex189';
    // Get sender info (user)
    final userID = _auth.currentUser!.uid;

    List<String> ids = [adminID, userID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
