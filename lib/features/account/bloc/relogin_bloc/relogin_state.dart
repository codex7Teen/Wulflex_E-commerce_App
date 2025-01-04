part of 'relogin_bloc.dart';

abstract class ReloginState extends Equatable {
  const ReloginState();

  @override
  List<Object> get props => [];
}

final class ReloginInitial extends ReloginState {}

//! Relogin success
class ReloginSuccess extends ReloginState {}

//! loading
class ReloginLoading extends ReloginState {}

//! Google loading
class GoogleLoading extends ReloginState {}

//! Login error
class ReloginError extends ReloginState {
  final String errorMessage;

  const ReloginError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
