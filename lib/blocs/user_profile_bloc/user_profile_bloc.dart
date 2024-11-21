import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/models/user_model.dart';
import 'package:wulflex/services/user_profile_services.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileServices userProfileService;
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
        await userProfileService.updateUser(event.updates);
        final user = await userProfileService.fetchUserProfile();
        if (user != null) {
          emit(UserProfileLoaded(user));
          log('UPDATE USER PROFILE SUCCESS');
        }
      } catch (error) {
        emit(UserProfileError(error.toString()));
        log(error.toString());
      }
    });
  }
}
