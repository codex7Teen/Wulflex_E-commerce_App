part of 'authenticaton_bloc_bloc.dart';

abstract class AuthenticatonBlocEvent extends Equatable {
  const AuthenticatonBlocEvent();

  @override
  List<Object> get props => [];
}

//! S I G N - U P
class SignUpButtonPressed extends AuthenticatonBlocEvent {
  final String email;
  final String password;

  SignUpButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

//! L O G I N
class LoginButtonPressed extends AuthenticatonBlocEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

//! R E S E T - P A S S W O R D
class PasswordResetButtonPressed extends AuthenticatonBlocEvent {
  final String email;
  
  PasswordResetButtonPressed({required this.email});

  @override
  List<Object> get props => [email];
}

//! L O G - O U T
class LogOutButtonPressed extends AuthenticatonBlocEvent {}

//! G O O G L E - S I G N U P
class GoogleLoginPressed extends AuthenticatonBlocEvent {}