part of 'notification_bloc_bloc.dart';

abstract class NotificationBlocEvent extends Equatable {
  const NotificationBlocEvent();

  @override
  List<Object> get props => [];
}

class CheckNotificationPermission extends NotificationBlocEvent {}

class ToggleNotification extends NotificationBlocEvent {
  final bool enabled;
  const ToggleNotification(this.enabled);

  @override
  List<Object> get props => [enabled];
}
