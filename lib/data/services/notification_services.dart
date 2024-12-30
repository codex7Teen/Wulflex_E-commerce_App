import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  Future<void> requestPermission() async {
    // Request permission to show notification
    PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Permission not granted');
    }
  }

  final _firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Upload fcm token to firebase
  Future<void> uploadFcmToken() async {
    try {
      final userID = _auth.currentUser!.uid;
      await _firebaseMessaging.getToken().then((token) async {
        log('Get Token :: $token');
        await _firebaseFirestore
            .collection('users')
            .doc(userID)
            .set({'notification_token': token});
      });
      _firebaseMessaging.onTokenRefresh.listen((token) async {
        log('Get Token :: $token');
        await _firebaseFirestore
            .collection('users')
            .doc(userID)
            .set({'notification_token': token});
      });
    } catch (error) {
      log('SERVICES: ERROR ${error.toString()}');
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show notification
  showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    int notificationID = 1;

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        notificationID,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: 'Not present');
  }
}
