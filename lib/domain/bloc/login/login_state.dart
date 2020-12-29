part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.failureMessage});

  final FormzStatus status;
  final Username username;
  final Password password;
  final String failureMessage;

  LoginState copyWith({
    FormzStatus status,
    Username username,
    Password password,
    String failureMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
