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
          log("USER CREATE SUCCESS: EMAIL = ${user.email}");
          emit(SignUpSuccess(emailId: user.email.toString(), userId: user.uid));
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
          log("USER LOGIN SUCCESS: EMAIL = ${user.email}");
          emit(LoginSuccess(emailId: user.email.toString(), userId: user.uid));
        }
      } catch (error) {
        log("LOGIN UNKNOWN ERROR ${error.toString()}");
        emit(LoginFailture(error: error.toString()));
      }
    });

    //! Handling the password reset event
    on<PasswordResetButtonPressed>((event, emit) async {
      emit(PasswordResetLoading());
      try {
        await authService.resetPassword(event.email);
        log("PASSWORD RESET SUCCESS");
        emit(PasswordResetSuccess());
      } catch (error) {
        emit(LoginFailture(error: error.toString()));
      }
    });

    //! Handling the logOut event
    on<LogOutButtonPressed>((event, emit) async {
      emit(LogOutLoading());
      try {
        await authService.signOut();
        log("LOG OUT SUCCESS");
        emit(LogOutSuccess());
      } catch (error) {
        emit(LogOutFailture(error: error.toString()));
      }
    });

    //! Handling the Google Login event
    on<GoogleLoginPressed>((event, emit) async {
      emit(GoogleLogInLoading());
      try {
        final authResults = await authService.loginWithGoogle();
        if (authResults != null) {
          log("GOOGLE LOGIN SUCCESS");
          // If new user loggin in save the details to firebase
          if (authResults.additionalUserInfo!.isNewUser) {
            emit(GoogleFirstLoginSuccess(
                userId: authResults.user!.uid,
                emailId: authResults.user!.email!,
                name: authResults.user!.displayName!));
          } else {
            emit(GoogleLogInSuccess());
          }
        }
      } catch (error) {
        log("GOOGLE LOGIN ERROR ${error.toString()}");
        emit(GoogleLogInFailture(error: error.toString()));
      }
    });
  }
}
