import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optovik/data/api/service/auth_service.dart';
import 'package:optovik/domain/model/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authService) : super(AuthUninitialized());

  final AuthService _authService;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }

    if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    }

    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }

    if (event is UpdateUser) {
      yield AuthUninitialized();
      yield AuthAuthenticated(user: event.user);
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    yield AuthUninitialized();
    // try {
      if (await _authService.hasToken()) {
        User user = await _authService.getUser();
        print(user.username);
        yield AuthAuthenticated(user: user);
      } else {
        yield AuthUnauthenticated();
      }
    // } on SocketException {
    //   yield AuthFailure('Проверьте подключение к интернету!');
    // } catch (e) {
    //   print(e);
    //   yield AuthTokenExpired();
    // }
  }

  Stream<AuthState> _mapLoggedInToState(LoggedIn event) async* {
    yield AuthLoading();

    try {
      User user = await _authService.login(event.username, event.password);

      yield AuthAuthenticated(user: user);
    } catch (e) {
      print(e);
      yield AuthFailure(e.toString());
    }
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield AuthLoading();
    try {
      await _authService.logout();
      yield AuthUnauthenticated();
    } catch (e) {
      print(e);
      yield AuthFailure(e.toString());
    }
  }
}
