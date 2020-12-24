import 'package:meta/meta.dart';
import 'package:optovik/data/api/api_utils.dart';
import 'package:optovik/data/api/response/feedback_response.dart';
import 'package:optovik/domain/repository/feedback_repository.dart';

class FeedbackDataRepository extends FeedbackRepository {
  final ApiUtil _apiUtil;

  FeedbackDataRepository(this._apiUtil);

  @override
  Future<FeedbackResponse> getFeedbackPage() async {
    return await _apiUtil.getFeedback();
  }

  @override
  Future<void> sendMessage({
    @required String theme,
    @required String email,
    @required String message,
    @required String fullName,
  }) async {
    await _apiUtil.sendFeedbackMessage();
  }
}
