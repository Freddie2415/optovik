part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String username;
  final String password;

  const LoggedIn({
    @required this.username,
    @required this.password,
  }) : assert(username != null);

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'LoggedIn {login: $username, password: $password}';
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