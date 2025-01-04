part of 'relogin_bloc.dart';

abstract class ReloginEvent extends Equatable {
  const ReloginEvent();

  @override
  List<Object> get props => [];
}

//! RELOGIN USEING EMIAL AND PADD
class ReloginUsingEmailAndPasswordEvent extends ReloginEvent {
  final String email;
  final String password;

  const ReloginUsingEmailAndPasswordEvent(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

//! RELOGIN USEING EMIAL AND PADD
class ReloginUsingGoogleEvent extends ReloginEvent {}
