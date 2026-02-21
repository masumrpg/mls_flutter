part of 'auth_status_cubit.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();

  @override
  List<Object> get props => [];
}

class AuthStatusInitial extends AuthStatusState {
  const AuthStatusInitial();
}

class AuthStatusLoading extends AuthStatusState {
  const AuthStatusLoading();
}

class AuthStatusSuccess extends AuthStatusState {
  const AuthStatusSuccess();
}

class AuthStatusError extends AuthStatusState {
  final String message;
  const AuthStatusError(this.message);

  @override
  List<Object> get props => [message];
}
