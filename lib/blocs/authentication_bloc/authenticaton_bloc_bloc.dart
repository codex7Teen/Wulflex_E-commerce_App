import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/services/authentication/login_authorization.dart';

part 'authenticaton_bloc_event.dart';
part 'authenticaton_bloc_state.dart';

class AuthenticatonBlocBloc extends Bloc<AuthenticatonBlocEvent, AuthenticatonBlocState> {
  final AuthService authService;
  AuthenticatonBlocBloc({required this.authService}) : super(SignUpInitial()) {
    //! Handling the signup event
    on<SignUpButtonPressed>((event, emit) async {
      emit(SignUpLoading());
      try {
        final user = await authService.createUserWithEmailAndPassword(event.email, event.password);
        if (user != null) {
          log("USER CREATE SUCCESS");
          emit(SignUpSuccess());
        } else {
          emit(SignUpFailture(error: "Failed to sign up user"));
        }
      } catch (error) {
        emit(SignUpFailture(error: error.toString()));
      }
    });
  }
}
