import 'package:flutter/cupertino.dart';
import 'package:optovik/data/api/response/feedback_response.dart';

class FeedbackService {

  Future<FeedbackResponse> getFeedback() async {
    return FeedbackResponse("+998 99 999 99 99", "tel:+998999999999");
  }

  Future<void> sendMessage({
    @required String theme,
    @required String email,
    @required String message,
    @required String fullName,
  }) async {
    await Future.delayed(Duration(seconds: 1));
  }
}
