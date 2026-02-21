import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginStarted>(_onStarted);
    on<LoginDataRequested>(_onDataRequested);
  }

  Future<void> _onStarted(
    LoginStarted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    // Your initialization logic here
    emit(const LoginSuccess());
  }

  Future<void> _onDataRequested(
    LoginDataRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      // Your data fetching logic here
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
