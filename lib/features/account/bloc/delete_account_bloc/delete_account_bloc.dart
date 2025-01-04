import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/services/authentication/login_authorization.dart';
part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final AuthService authService;
  DeleteAccountBloc({required this.authService})
      : super(const DeleteAccountInitial([false, false, false, false])) {
    //! Checkbox checked
    on<ToggleCheckboxEvent>((event, emit) {
      if (state is DeleteAccountInitial) {
        final currentStates = (state as DeleteAccountInitial).checkBoxStates;
        final updatedStates = List<bool>.from(currentStates)
          ..[event.index] = event.isChecked;
        emit(DeleteAccountInitial(updatedStates));
      }
    });

    //! Delete account pressed
    on<DeleteAccountButtonPressed>((event, emit) async {
      if (state is DeleteAccountInitial) {
        final currentStates = (state as DeleteAccountInitial).checkBoxStates;
        emit(DeleteAccountLoading());
        try {
          // First delete user details (image and Firestore document)
          await authService.deleteAllUserDetails();
          log("USER DETAILS DELETED SUCCESS");

          // Then delete the actual user account
          await authService.deleteUser();
          log("ACCOUNT DELETED SUCCESS");

          emit(DeleteAccountSuccess());
          // Reset to initial state for further attempts
          emit(DeleteAccountInitial(currentStates));
        } catch (error, stackTrace) {
          // Log the error and stack trace for debugging
          log("ACCOUNT DELETED FAILED: $error", stackTrace: stackTrace);
          // Emit the failture state with error message
          emit(const DeleteAccountFailure(
              errorMessage: "Failed to delete account: Unknown error"));
        } finally {
          // Reset to initial state for further attempts
          emit(DeleteAccountInitial(currentStates));
        }
      }
    });

    //! Reset checkboxes after account deleted
    on<ResetCheckboxStatesEvent>((event, emit) {
      emit(const DeleteAccountInitial([false, false, false, false]));
    });
  }
}
