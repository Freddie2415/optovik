import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/repository/feedback_repository.dart';
import 'package:meta/meta.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc(this._feedbackRepository) : super(FeedbackInitial());

  final FeedbackRepository _feedbackRepository;

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
      final response = await _feedbackRepository.getFeedbackPage();
      await Future.delayed(Duration(milliseconds: 700));
      yield FeedbackSuccess(phone: response.phone, tel: response.tel);
    } catch (e) {
      print(e);
      yield FeedbackFailure(message: e.toString());
    }
  }

  Stream<FeedbackState> _sendMessage(SendMessageFeedback event) async* {
    yield FeedbackSendingMessage();

    try {
      await _feedbackRepository.sendMessage(
        fullName: event.fullName,
        theme: event.theme,
        message: event.message,
        email: event.email,
      );
      // throw "Что то пошло не так";
      yield FeedbackMessageSent();

      await Future.delayed(Duration(seconds: 1));

      yield FeedbackInitial();
    } catch (e) {
      print(e);
      yield FeedbackFailure(message: e.toString());
    }
  }
}
