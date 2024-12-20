part of 'delete_account_bloc.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

//! Initial state with all checkboxes unchecked
final class DeleteAccountInitial extends DeleteAccountState {
  final List<bool> checkBoxStates;

  const DeleteAccountInitial(this.checkBoxStates);

  @override
  List<Object> get props => [checkBoxStates];
}

//! State when account deletion succeeds
class DeleteAccountSuccess extends DeleteAccountState {}

//! State when account deletion loading
class DeleteAccountLoading extends DeleteAccountState {}

//! State when account deletion fails
class DeleteAccountFailure extends DeleteAccountState {
  final String errorMessage;
  DeleteAccountFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}