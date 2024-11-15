import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    //! Pick Image
    on<PickImageEvent>((event, emit) async {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          log("IMAGE PICKED SUCCESS");
          emit(ImagePickerLoaded(File(image.path)));
        }
      } catch (e) {
        log("IMAGE PICKED SUCCESS");
        emit(ImagePickerFailed());
      }
    });
  }
}
