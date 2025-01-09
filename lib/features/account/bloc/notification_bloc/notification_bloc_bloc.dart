import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/services/notification_services.dart';

part 'notification_bloc_event.dart';
part 'notification_bloc_state.dart';

class NotificationBlocBloc
    extends Bloc<NotificationBlocEvent, NotificationBlocState> {
  final NotificationServices _notificationServices;
  NotificationBlocBloc(this._notificationServices)
      : super(const NotificationBlocInitial(false)) {
    //! CHECK PERMISSION BLOC
    on<CheckNotificationPermission>(_checkPermission);
    //! TOGGEL NOTIFICATION BLOC
    on<ToggleNotification>(_toggleNotification);
  }

  Future<void> _checkPermission(
    CheckNotificationPermission event,
    Emitter<NotificationBlocState> emit,
  ) async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      if (userID == null) {
        emit(const NotificationUpdated(false));
        return;
      }

      // Check both Firestore and current device permission status
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();
      final notificationToken = userDoc.data()?['notification_token'];
      
      // Check current permission status
      final permissionStatus = await _notificationServices.checkPermissionStatus();
      
      // Only consider notifications enabled if both token exists and permission is granted
      emit(NotificationUpdated(notificationToken != null && permissionStatus));
    } catch (e) {
      emit(const NotificationUpdated(false));
    }
  }

  Future<void> _toggleNotification(
    ToggleNotification event,
    Emitter<NotificationBlocState> emit,
  ) async {
    if (event.enabled) {
      try {
        // First check current permission status
        final currentStatus = await _notificationServices.checkPermissionStatus();
        
        if (!currentStatus) {
          // If not granted, open system settings
          await _notificationServices.openSettings();
          
          // Check if permission was granted after settings were opened
          final newStatus = await _notificationServices.checkPermissionStatus();
          if (!newStatus) {
            emit(const NotificationUpdated(false));
            return;
          } 
        }
        
        // If we have permission, proceed with token upload
        await _notificationServices.uploadFcmToken();
        emit(const NotificationUpdated(true));
      } catch (e) {
        emit(const NotificationUpdated(false));
      }
    } else {
      try {
        final userID = FirebaseAuth.instance.currentUser?.uid;
        if (userID != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .update({'notification_token': null});
          emit(const NotificationUpdated(false));
        }
      } catch (e) {
        // Handle error
        emit(state); // Maintain current state on error
      }
    }
  }
}
