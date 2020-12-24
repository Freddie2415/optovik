part of 'feedback_bloc.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class FetchFeedback extends FeedbackEvent {}

class SendMessageFeedback extends FeedbackEvent {
  final String fullName;
  final String email;
  final String theme;
  final String message;

  const SendMessageFeedback({
    this.fullName,
    this.email,
    this.theme,
    this.message,
  });

  @override
  List<Object> get props => [fullName, email, theme, message];
}
