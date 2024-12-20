part of 'delete_account_bloc.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

//! Event to toggle specific checkbox
class ToggleCheckboxEvent extends DeleteAccountEvent {
  final int index;
  final bool isChecked;

  const ToggleCheckboxEvent(this.index, this.isChecked);

  @override
  List<Object> get props => [index, isChecked];
}

//! Event for attempting to delete the account
class DeleteAccountButtonPressed extends DeleteAccountEvent {}

//! Event for resetting the checkbox states
class ResetCheckboxStatesEvent extends DeleteAccountEvent {}