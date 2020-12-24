part of 'feedback_bloc.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackSuccess extends FeedbackState {
  final String phone;
  final String tel;

  const FeedbackSuccess({this.phone, this.tel});

  @override
  List<Object> get props => [phone, tel];
}

class FeedbackFailure extends FeedbackState {
  final String message;

  FeedbackFailure({@required this.message});

  @override
  List<Object> get props => [message];
}

class FeedbackSendingMessage extends FeedbackState {}

class FeedbackMessageSent extends FeedbackState {

}
