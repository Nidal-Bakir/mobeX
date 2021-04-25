import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/auth/data/model/user_profiel.dart';
import 'package:mobox/core/auth/repository/auth_repo.dart';


import 'package:mobox/core/error/exception.dart';

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
      yield* _authTokenLoadedStateHandler();
    } else if (event is AuthLoginRequested) {
      yield* _authLoginRequestedStateHandler(event.userName, event.password);
    } else if (event is AuthAccountCreated) {
      yield AuthCreateAccount();
    }
  }

  Stream<AuthState> _authLoginRequestedStateHandler(
      String userName, String password) async* {
    yield AuthLoadUserProfileInProgress();
    try {
      var userProfile = await _authRepo.login(userName: userName, password: password);
      yield AuthLoadUserProfileSuccess(userProfile: userProfile);
    } on CannotLoginException catch (e) {
      yield AuthLoadUserProfileFailure(message: e.message);
    } on AuthenticationException catch (e) {
      yield AuthLoadUserProfileFailure(message: e.message);
    }
  }

  Stream<AuthState> _authTokenLoadedStateHandler() async* {
    var userProfile = _authRepo.getUserToken();
    if (userProfile == null) {
      yield AuthLoadUserProfileNotAuthenticated();
    } else {
      yield AuthLoadUserProfileSuccess(userProfile: userProfile);
    }
  }
}
