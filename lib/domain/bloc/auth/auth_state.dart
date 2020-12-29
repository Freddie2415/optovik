part of 'auth_bloc.dart';

class AuthState extends Equatable {

  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.message,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  // const AuthState.error(String message)
  //     : this._(
  //         status: AuthenticationStatus.error,
  //         message: message,
  //       );

  final AuthenticationStatus status;
  final User user;
  final String message;


  @override
  List<Object> get props => [status, user];
}
