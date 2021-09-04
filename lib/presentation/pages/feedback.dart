import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/feedback/feedback_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/pages/feedback_form.dart';
import 'package:optovik/presentation/widgets/error_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBack extends StatelessWidget {
  final FeedbackBloc feedbackBloc;

  const FeedBack({Key key, @required this.feedbackBloc})
      : assert(feedbackBloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).feedback),
      ),
      body: BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: _builder,
        cubit: feedbackBloc..add(FetchFeedback()),
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
            child: Text(S.of(context).feedbackText),
          ),
          ...state.supportNumbers
              .map(
                (e) => ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.indigo,
                  ),
                  title: Text(
                    "${e.phone}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  onTap: () {
                    launch(e.tel);
                  },
                ),
              )
              .toList(),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.indigo,
            ),
            title: Text(
              S.of(context).letterToTechSupport,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            onTap: () {
              Navigator.push(context, FeedbackFormPage.route(feedbackBloc));
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
