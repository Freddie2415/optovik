import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/data/api/service/feedback_service.dart';
import 'package:optovik/domain/model/support_number.dart';
import 'package:meta/meta.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackService feedbackService;

  FeedbackBloc(this.feedbackService) : super(FeedbackInitial());

  @override
  Stream<FeedbackState> mapEventToState(
    FeedbackEvent event,
  ) async* {
    if (event is FetchFeedback) {
      yield* _fetch(event);
    }

    if (event is SendMessageFeedback) {
      yield* _sendMessage(event);
    }
  }

  Stream<FeedbackState> _fetch(FetchFeedback event) async* {
    try {
      final response = await feedbackService.getFeedback();
      final supportNumbers =
          response.map((e) => SupportNumber(e.phone)).toList();

      await Future.delayed(Duration(milliseconds: 700));
      yield FeedbackSuccess(supportNumbers: supportNumbers);
    } catch (e) {
      print(e);
      yield FeedbackFailure(message: e.toString());
    }
  }

  Stream<FeedbackState> _sendMessage(SendMessageFeedback event) async* {
    yield FeedbackSendingMessage();

    try {
      await feedbackService.sendMessage(
        fullName: event.fullName,
        theme: event.theme,
        message: event.message,
        email: event.email,
      );

      await Future.delayed(Duration(milliseconds: 500));

      yield FeedbackMessageSent();

      await Future.delayed(Duration(milliseconds: 700));

      yield FeedbackInitial();
    } catch (e) {
      print(e);
      yield FeedbackFailure(message: e.toString());
    }
  }
}
