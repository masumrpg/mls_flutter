import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_status_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  AuthStatusCubit() : super(AuthStatusInitial());

  void doSomething() {
    emit(AuthStatusLoading());
    // Your logic here
    emit(AuthStatusSuccess());
  }
}
