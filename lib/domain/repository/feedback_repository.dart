import 'package:meta/meta.dart';
import 'package:optovik/data/api/response/feedback_response.dart';

abstract class FeedbackRepository {
  Future<FeedbackResponse> getFeedbackPage();

  Future<void> sendMessage({
    @required String theme,
    @required String email,
    @required String message,
    @required String fullName,
  });
}
