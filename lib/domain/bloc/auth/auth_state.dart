part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthUninitialized extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated({this.user});

  @override
  String toString() => 'AuthAuthenticated: $user';
}

class AuthUnauthenticated extends AuthState {}

class AuthTokenExpired extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {}
