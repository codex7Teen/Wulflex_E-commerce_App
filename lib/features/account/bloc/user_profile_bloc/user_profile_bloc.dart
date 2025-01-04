import 'dart:developer';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wulflex/data/models/user_model.dart';
import 'package:wulflex/data/services/user_profile_services.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileServices userProfileService;
  File? selectedImage; // to retain the selected image
  UserProfileBloc(this.userProfileService) : super(UserProfileInitial()) {
    //! CREATE USER PROFILE BLOC
    on<CreateUserProfileEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        await userProfileService.createUserProfile(event.user);
        emit(UserProfileLoaded(event.user));
        log('CREATE USER PROFILE SUCCESS');
      } catch (error) {
        emit(UserProfileError(error.toString()));
        log(error.toString());
      }
    });

      //! RESET SELECTED IMAGE
    on<ResetProfileStateEvent>((event, emit) {
      selectedImage = null;
      emit(UserProfileInitial());
      log('PROFILE STATE RESET');
    });

    //! FETCH USER PROFILE BLOC
    on<FetchUserProfileEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        final user = await userProfileService.fetchUserProfile();
        if (user != null) {
          emit(UserProfileLoaded(user));
          log('FETCH USER PROFILE SUCCESS');
        }
      } catch (error) {
        UserProfileError(error.toString());
        log(error.toString());
      }
    });

    //! UPADTE USER PROFILE BLOC
    on<UpdateUserProfileEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        // Handle image upload if there's an image
        if (selectedImage != null) {
          try {
            // Upload with progress tracking
            final uploadResult = await userProfileService
                .uploadImage(selectedImage!, (progress) {
              emit(ImageUploadProgress(
                  progress: progress, selectedImage: selectedImage!));
            });
            event.updates['userImage'] = uploadResult;
          } catch (error) {
            log('Image upload failed: $error');
            // You can optionally show a warning here but continue updating other fields
          }
        }

        // Proceed to update other fields in Firestore
        await userProfileService.updateUser(event.updates);

        // Fetch the updated user profile
        final updatedUser = await userProfileService.fetchUserProfile();
        if (updatedUser != null) {
           // Clear the selected image after successful update
          selectedImage = null;
          emit(UserProfileLoaded(updatedUser));
          log('UPDATE USER PROFILE SUCCESS');
        } else {
          throw Exception('Failed to fetch updated profile');
        }
      } catch (error) {
        emit(UserProfileError(error.toString()));
        log('UPDATE USER PROFILE FAILED: $error');
      }
    });

    //! PICK IMAGE
    on<PickImageEvent>((event, emit) async {
      try {
        final ImagePicker picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedImage = File(pickedFile.path); // Retain the image
          emit(ImagePickerLoaded(selectedImage!));
          log("IMAGE PICKED SUCCESS");
        }
      } catch (e) {
        log("IMAGE PICKING FAILED");
        emit(ImagePickerFailed());
      }
    });
  }
}
