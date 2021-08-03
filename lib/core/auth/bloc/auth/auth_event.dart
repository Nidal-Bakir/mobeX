part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthUserProfileLoaded extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String userName, password;

  AuthLoginRequested({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}

class AuthAccountCreated extends AuthEvent {
  @override
  List<Object?> get props => [];
}
class AuthUpdateUserProfileLoaded extends AuthEvent {
  @override
  List<Object?> get props => [];
}
class AuthGuestUserCreated extends AuthEvent {
  @override
  List<Object?> get props => [];
}
