import 'package:optovik/domain/bloc/feedback/feedback_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';

class FeedbackModule {
  static feedbackBloc() {
    return FeedbackBloc(RepositoryModule.feedbackRepository());
  }
}
