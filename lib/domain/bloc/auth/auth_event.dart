part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String login;
  final String password;

  const LoggedIn({
    @required this.login,
    @required this.password,
  }) : assert(login != null);

  @override
  List<Object> get props => [login, password];

  @override
  String toString() => 'LoggedIn {login: $login, password: $password}';
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'Log out';
}

class UpdateUser extends AuthEvent {
  final User user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class AuthExpired extends AuthEvent {}
