import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mobox/data/repository/auth_repo.dart';
import 'package:mobox/utils/exception.dart';
import 'package:url_launcher/url_launcher.dart';

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
    if (event is AuthTokenLoaded) {
      yield* _authTokenLoadedStateHandler();
    } else if (event is AuthLoginRequested) {
      yield* _authLoginRequestedStateHandler(event.userName, event.password);
    } else if (event is AuthAccountCreated) {
      if (await canLaunch('https://flutter.dev')) {
       await launch('https://flutter.dev');
      }
    }
  }

  Stream<AuthState> _authLoginRequestedStateHandler(
      String userName, String password) async* {
    try {
      var token = await _authRepo.login(userName: userName, password: password);
      yield AuthLoadTokenSuccess(token: token);
    } on CannotLoginException catch (e) {
      yield AuthLoadTokenFailure(message: e.message);
    } on AuthenticationException catch (e) {
      yield AuthLoadTokenFailure(message: e.message);
    }
  }

  Stream<AuthState> _authTokenLoadedStateHandler() async* {
    var userToken = await _authRepo.getUserToken();
    if (userToken == null) {
      yield AuthLoadTokenNotAuthenticated();
    } else {
      yield AuthLoadTokenSuccess(token: userToken);
    }
  }
}
