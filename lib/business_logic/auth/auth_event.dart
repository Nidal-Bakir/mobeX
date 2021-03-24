part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthTokenLoaded extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String userName, password;

  AuthLoginRequested({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}
