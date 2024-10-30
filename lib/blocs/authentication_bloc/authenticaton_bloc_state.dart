part of 'authenticaton_bloc_bloc.dart';

abstract class AuthenticatonBlocState extends Equatable {
  const AuthenticatonBlocState();
  
  @override
  List<Object> get props => [];
}

class SignUpInitial extends AuthenticatonBlocState {}

class SignUpLoading extends AuthenticatonBlocState {}

class SignUpSuccess extends AuthenticatonBlocState {}

class SignUpFailture extends AuthenticatonBlocState {
  final String error;
  SignUpFailture({required this.error});

  @override
  List<Object> get props => [error];
}
