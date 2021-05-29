part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CheckLastRegisterEvent extends RegisterEvent {}

class TryRegisterEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  TryRegisterEvent({
    @required this.firstName,
    @required this.lastName,
    @required this.username,
    @required this.password,
  });
}

class VerifySMSRegisterEvent extends RegisterEvent {
  final String smsCode;

  VerifySMSRegisterEvent({@required this.smsCode});
}
