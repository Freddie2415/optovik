import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/feedback/feedback_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/feedback_module.dart';
import 'package:optovik/presentation/pages/feedback_form.dart';
import 'package:optovik/presentation/widgets/error_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBack extends StatelessWidget {
  // ignore: close_sinks
  final FeedbackBloc _feedbackBloc = FeedbackModule.feedbackBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.feedback),
      ),
      body: BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: _builder,
        cubit: _feedbackBloc..add(FetchFeedback()),
      ),
    );
  }

  Widget _builder(BuildContext context, FeedbackState state) {
    if (state is FeedbackSuccess) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Text(S.current.feedbackText),
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.lightGreen,
            ),
            title: Text(
              "${state.phone}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
            onTap: () {
              launch(state.tel);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.lightGreen,
            ),
            title: Text(
              S.current.letterToTechSupport,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
            onTap: () {
              Navigator.push(context, FeedbackFormPage.route());
            },
          ),
        ],
      );
    }
    if (state is FeedbackFailure) {
      return FailureWidget(
        message: state.message,
        onBtnPressed: () {},
      );
    }

    return LoadingWidget();
  }
}
