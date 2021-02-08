import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optovik/domain/model/user.dart';
import 'package:optovik/domain/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._userRepository) : super(AuthUninitialized());

  final UserRepository _userRepository;

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

    if (event is AuthExpired) {
      yield AuthTokenExpired();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    yield AuthUninitialized();
    await Future.delayed(Duration(milliseconds: 1500));
    try {
      final bool hasValidToken = await _userRepository.hasToken();
      if (hasValidToken) {
        yield AuthAuthenticated(user: await _userRepository.getUser());
      } else {
        yield AuthUnauthenticated();
      }
    } on SocketException {
      yield AuthFailure();
    } catch (e) {
      print(e);
      yield AuthTokenExpired();
    }
  }

  Stream<AuthState> _mapLoggedInToState(LoggedIn event) async* {
    yield AuthLoading();

    await Future.delayed(Duration(seconds: 1));

    await _userRepository.authenticate(login: event.login, password: event.password);

    await _userRepository.saveToken(jwt: event.login);

    yield AuthAuthenticated(user: await _userRepository.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield AuthLoading();
    await _userRepository.deleteToken();
    yield AuthUnauthenticated();
  }


}
