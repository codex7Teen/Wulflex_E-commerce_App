import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/services/authentication/login_authorization.dart';

part 'authenticaton_bloc_event.dart';
part 'authenticaton_bloc_state.dart';

class AuthenticatonBlocBloc
    extends Bloc<AuthenticatonBlocEvent, AuthenticatonBlocState> {
  final AuthService authService;
  AuthenticatonBlocBloc({required this.authService})
      : super(AuthenticatonInitial()) {
    //! Handling the signup event
    on<SignUpButtonPressed>((event, emit) async {
      emit(SignUpLoading());
      try {
        final user = await authService.createUserWithEmailAndPassword(
            event.email, event.password);
        if (user != null) {
          log("USER CREATE SUCCESS");
          emit(SignUpSuccess());
        } else {
          emit(SignUpFailture(error: "Failed to sign-up user"));
        }
      } catch (error) {
        emit(SignUpFailture(error: error.toString()));
      }
    });

    //! Handling the login event
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await authService.loginUserWithEmailAndPassword(
            event.email, event.password);
        if (user != null) {
          log("USER LOGIN SUCCESS");
          emit(LoginSuccess());
        } else {
          emit(LoginFailture(error: "Failed to login user"));
        }
      } catch (error) {
        emit(LoginFailture(error: error.toString()));
      }
    });
  }
}
