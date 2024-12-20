import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/data/services/authentication/login_authorization.dart';

part 'relogin_event.dart';
part 'relogin_state.dart';

class ReloginBloc extends Bloc<ReloginEvent, ReloginState> {
  final AuthService authService;
  ReloginBloc(this.authService) : super(ReloginInitial()) {
    //! Relogin using emial and pass
    on<ReloginUsingEmailAndPasswordEvent>((event, emit) async {
      emit(ReloginLoading());
      try {
        await authService.reauthenticateUser(event.email, event.password);
        emit(ReloginSuccess());
      } catch (error) {
        emit(ReloginError(errorMessage: error.toString()));
      }
    });

    //! Relogin using google
    on<ReloginUsingGoogleEvent>((event, emit) async {
      emit(GoogleLoading());
      try {
        await authService.reauthenticateWithGoogle();
        emit(ReloginSuccess());
      } catch (error) {
        emit(ReloginError(errorMessage: error.toString()));
      }
    });
  }
}
