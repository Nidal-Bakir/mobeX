part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];

  const AuthInitial();
}

class AuthLoadTokenSuccess extends AuthState {
  final String token;

  AuthLoadTokenSuccess({required this.token});

  @override
  List<Object?> get props => [token];
}

class AuthLoadTokenInProgress extends AuthState {
  const AuthLoadTokenInProgress();

  @override
  List<Object?> get props => [];
}

class AuthLoadTokenNotAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadTokenFailure extends AuthState {
  final String message;

  AuthLoadTokenFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthCreateAccount extends AuthState {
  @override
  List<Object?> get props => [];
}
