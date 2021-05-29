part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class TryingRegisterState extends RegisterState {}

class RegisterSMSVerifyState extends RegisterState {
  final String phone;

  RegisterSMSVerifyState(this.phone);
}

class RegisterSMSVerifyingState extends RegisterState {}

class RegisteredSuccessfullyState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  final String message;

  const RegisterFailureState(this.message);

  @override
  List<Object> get props => [];
}
