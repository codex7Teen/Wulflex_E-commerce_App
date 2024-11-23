part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  final UserModel user;

  UserProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserProfileError extends UserProfileState {
  final String error;

  UserProfileError(this.error);

  @override
  List<Object> get props => [error];
}

class ImagePickerLoaded extends UserProfileState {
  final File selectedImage;
  ImagePickerLoaded(this.selectedImage);

  @override
  List<Object> get props => [selectedImage];
}

class ImagePickerFailed extends UserProfileState {}

//! TRACK IMAGE UPLOAD PROGRESS
class ImageUploadProgress extends UserProfileState {
  final double progress;
  final File selectedImage;

  ImageUploadProgress({required this.progress, required this.selectedImage});

  @override
  List<Object> get props => [progress, selectedImage];
}
