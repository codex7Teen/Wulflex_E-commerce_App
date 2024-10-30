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
