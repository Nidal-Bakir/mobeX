import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/auth/repository/auth_repo.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/user_profiel.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserProfileLoaded) {
      yield* _authUserProfileLoadedHandler();
    } else if (event is AuthLoginRequested) {
      yield* _authLoginRequestedHandler(event.userName, event.password);
    } else if (event is AuthAccountCreated) {
      yield AuthCreateAccount();
    } else if (event is AuthUpdateUserProfileLoaded) {
      yield* _authUpdateUserProfileLoadedHandler();
    } else if (event is AuthGuestUserCreated) {
      yield AuthLoadUserProfileSuccess(
          userProfile: _authRepo.getGuestUserProfile());
    }
  }

  Stream<AuthState> _authLoginRequestedHandler(
      String userName, String password) async* {
    yield AuthLoadUserProfileInProgress();
    try {
      var userProfile =
          await _authRepo.login(userName: userName, password: password);
      yield AuthLoadUserProfileSuccess(userProfile: userProfile);
    } on ConnectionException catch (e) {
      yield AuthLoadUserProfileFailure(message: e.message);
    } on AuthenticationException catch (e) {
      yield AuthLoadUserProfileFailure(message: e.message);
    }
  }

  Stream<AuthState> _authUserProfileLoadedHandler() async* {
    var userProfile = _authRepo.getUserProfile();
    if (userProfile == null) {
      yield AuthLoadUserProfileNotAuthenticated();
    } else {
      try {
        userProfile =
            await _authRepo.getUpdatedUserProfile(token: userProfile.token);
        if (userProfile.accountStatus == AccountStatus.suspend) {
          yield AuthAccountSuspend();
          return;
        }
        yield AuthLoadUserProfileSuccess(userProfile: userProfile);
      } on Exception {
        if (userProfile!.accountStatus == AccountStatus.suspend) {
          yield AuthAccountSuspend();
          return;
        }
        // fall back to local profile date in case of any error
        yield AuthLoadUserProfileSuccess(userProfile: userProfile);
      }
    }
  }

  Stream<AuthState> _authUpdateUserProfileLoadedHandler() async* {
    try {
      var userProfile = await _authRepo.getUpdatedUserProfile(
          token: _authRepo.getUserProfile()!.token);

      if (userProfile.accountStatus == AccountStatus.suspend) {
        yield AuthAccountSuspend();
        return;
      }

      yield AuthLoadUserProfileSuccess(userProfile: userProfile);
    } on ConnectionException catch (e) {
      yield AuthLoadUserProfileFailure(message: e.message);
    } on AuthenticationException catch (e) {
      yield AuthLoadUserProfileFailure(message: e.message);
    }
  }
}
