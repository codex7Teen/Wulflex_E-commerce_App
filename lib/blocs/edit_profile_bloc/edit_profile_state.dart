part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

class ImagePickerLoaded extends EditProfileState {
  final File selectedImage;
  ImagePickerLoaded(this.selectedImage);

  @override
  List<Object> get props => [selectedImage];
}

class ImagePickerFailed extends EditProfileState {}
