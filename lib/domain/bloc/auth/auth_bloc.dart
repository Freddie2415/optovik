import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/model/auth_status.dart';
import 'package:optovik/domain/model/user.dart';
import 'package:optovik/domain/repository/auth_repository.dart';
import 'package:optovik/domain/repository/user_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    @required authRepository,
    @required userRepository,
  })  : assert(authRepository != null),
        assert(userRepository != null),
        _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    _authStatusSubscription = authRepository.status.listen(
      (status) => add(AuthStatusChanged(status)),
    );
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authStatusSubscription;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStatusChanged) {
      yield await _mapAuthStatusChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      _authRepository.logOut();
    }
  }

  Future<AuthState> _mapAuthStatusChangedToState(
    AuthStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return user != null
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated();
      default:
        return const AuthState.unknown();
    }
  }

  Future<User> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authStatusSubscription?.cancel();
    _authRepository.dispose();
    return super.close();
  }
}
