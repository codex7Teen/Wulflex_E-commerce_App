part of 'notification_bloc_bloc.dart';

abstract class NotificationBlocState extends Equatable {
  final bool isNotificationEnabled;
  const NotificationBlocState(this.isNotificationEnabled);
  
  @override
  List<Object> get props => [isNotificationEnabled];
}

final class NotificationBlocInitial extends NotificationBlocState {
  const NotificationBlocInitial(super.isNotificationEnabled);
}

final class NotificationUpdated extends NotificationBlocState {
  const NotificationUpdated(super.isNotificationEnabled);
}