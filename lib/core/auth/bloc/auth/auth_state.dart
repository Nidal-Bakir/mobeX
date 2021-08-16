part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];

  const AuthInitial();
}

class AuthLoadUserProfileSuccess extends AuthState {
  final UserProfile userProfile;

  AuthLoadUserProfileSuccess({required this.userProfile});

  @override
  List<Object?> get props => [userProfile];
}

class AuthLoadUserProfileInProgress extends AuthState {
  const AuthLoadUserProfileInProgress();

  @override
  List<Object?> get props => [];
}

class AuthLoadUserProfileNotAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadUserProfileFailure extends AuthState {
  final String message;

  AuthLoadUserProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthCreateAccount extends AuthState {
  @override
  List<Object?> get props => [];
}
class AuthAccountSuspend extends AuthState {
  @override
  List<Object?> get props => [];
}
