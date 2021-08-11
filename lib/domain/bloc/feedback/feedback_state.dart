part of 'feedback_bloc.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackSuccess extends FeedbackState {
  final List<SupportNumber> supportNumbers;

  const FeedbackSuccess({this.supportNumbers});

  @override
  List<Object> get props => [supportNumbers];
}

class FeedbackFailure extends FeedbackState {
  final String message;

  FeedbackFailure({@required this.message});

  @override
  List<Object> get props => [message];
}

class FeedbackSendingMessage extends FeedbackState {}

class FeedbackMessageSent extends FeedbackState {}
