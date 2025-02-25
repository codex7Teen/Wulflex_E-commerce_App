import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;
  bool _hasPermission = false;

  // Check if we have notification permission
  bool get hasPermission => _hasPermission;

  Future<bool> requestPermission() async {
    try {
      // Request permission to show notification
      PermissionStatus status = await Permission.notification.request();
      _hasPermission = status == PermissionStatus.granted;
      return _hasPermission;
    } catch (error) {
      log('Permission request error: ${error.toString()}');
      _hasPermission = false;
      return false;
    }
  }

  // Check current permission status
  Future<bool> checkPermissionStatus() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  // Open system settings instead of requesting permission again
  Future<void> openSettings() async {
    await AppSettings.openAppSettings();
  }

  // Upload fcm token to firebase
  Future<void> uploadFcmToken() async {
    try {
      final userID = _auth.currentUser!.uid;
      await _firebaseMessaging.getToken().then((token) async {
        if (token == null) return;
        log('GET TOKEN :: $token');
        await _firebaseFirestore
            .collection('users')
            .doc(userID)
            .update({'notification_token': token});
      });

      _firebaseMessaging.onTokenRefresh.listen((token) async {
        log('Get Token :: $token');
        await _firebaseFirestore
            .collection('users')
            .doc(userID)
            .update({'notification_token': token});
      });
    } catch (error) {
      log('SERVICES: ERROR ${error.toString()}');
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    if (!_hasPermission) return; // Don't initialize if no permission

    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');

      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } catch (error) {
      log('Notification init error: ${error.toString()}');
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (!_hasPermission) return; // Don't show notification if no permission

    try {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('channel_id', 'Channel Name',
              channelDescription: 'Channel Description',
              importance: Importance.high,
              priority: Priority.high,
              ticker: 'ticker',
              icon: '@mipmap/launcher_icon');

      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
        1, // notification ID
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: 'Not present',
      );
    } catch (error) {
      log('Show notification error: ${error.toString()}');
    }
  }
}
