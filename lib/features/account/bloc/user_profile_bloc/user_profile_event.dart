part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

//! CREATE USER PROFILE EVENT
class CreateUserProfileEvent extends UserProfileEvent {
  final UserModel user;
  const CreateUserProfileEvent(this.user);

  @override
  List<Object> get props => [user];
}

//! FETCH USER PROFILE EVENT
class FetchUserProfileEvent extends UserProfileEvent {}

//! UPDATE USER PROFILE EVENT
class UpdateUserProfileEvent extends UserProfileEvent {
  final Map<String, dynamic> updates;

  const UpdateUserProfileEvent(this.updates);

  @override
  List<Object> get props => [updates];
}

//! PICK USER IMAGE EVENT
class PickImageEvent extends UserProfileEvent {}

//! RESET PROFILE STATE EVENT
class ResetProfileStateEvent extends UserProfileEvent{}