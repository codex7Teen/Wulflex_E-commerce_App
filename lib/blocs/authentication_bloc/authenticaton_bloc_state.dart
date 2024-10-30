part of 'authenticaton_bloc_bloc.dart';

abstract class AuthenticatonBlocState extends Equatable {
  const AuthenticatonBlocState();

  @override
  List<Object> get props => [];
}

// General initial state for all
class AuthenticatonInitial extends AuthenticatonBlocState {}

//! S I G N - U P
class SignUpLoading extends AuthenticatonBlocState {}

class SignUpSuccess extends AuthenticatonBlocState {}

class SignUpFailture extends AuthenticatonBlocState {
  final String error;
  SignUpFailture({required this.error});

  @override
  List<Object> get props => [error];
}

//! L O G I N
class LoginLoading extends AuthenticatonBlocState {}

class LoginSuccess extends AuthenticatonBlocState {}

class LoginFailture extends AuthenticatonBlocState {
  final String error;
  LoginFailture({required this.error});

  @override
  List<Object> get props => [error];
}

//! R E S E T - P A S S W O R D
class PasswordResetLoading extends AuthenticatonBlocState {}

class PasswordResetSuccess extends AuthenticatonBlocState {}

class PasswordResetFailture extends AuthenticatonBlocState {
  final String error;
  PasswordResetFailture({required this.error});

  @override
  List<Object> get props => [error];
}

//! L O G - O U T
class LogOutLoading extends AuthenticatonBlocState {}

class LogOutSuccess extends AuthenticatonBlocState {}

class LogOutFailture extends AuthenticatonBlocState {
  final String error;
  LogOutFailture({required this.error});

  @override
  List<Object> get props => [error];
}

//! G O O G L E - S I G N U P
class GoogleLogInLoading extends AuthenticatonBlocState {}

class GoogleLogInSuccess extends AuthenticatonBlocState {}

class GoogleLogInFailture extends AuthenticatonBlocState {
  final String error;
  GoogleLogInFailture({required this.error});

  @override
  List<Object> get props => [error];
}