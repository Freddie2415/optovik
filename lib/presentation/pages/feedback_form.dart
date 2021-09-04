import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/feedback/feedback_bloc.dart';
import 'package:optovik/generated/l10n.dart';

class FeedbackFormPage extends StatelessWidget {
  FeedbackFormPage({Key key, this.feedbackBloc}) : super(key: key);

  static Route<Object> route(FeedbackBloc feedbackBloc) {
    return MaterialPageRoute(
        builder: (context) => FeedbackFormPage(
              feedbackBloc: feedbackBloc,
            ));
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FeedbackBloc feedbackBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).letterToTechSupport),
      ),
      body: BlocListener(
        cubit: feedbackBloc,
        listener: (context, state) {
          if (state is FeedbackMessageSent) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  backgroundColor: Colors.indigo,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).messageSent.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.check, color: Colors.white)
                    ],
                  )));
            _formKey.currentState.reset();
          }
          if (state is FeedbackFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${state.message}"),
                  Icon(Icons.error),
                ],
              )));
          }
          if (state is FeedbackInitial) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration:
                      InputDecoration(labelText: S.of(context).requiredName),
                  validator: _validateText,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email *"),
                  keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                ),
                TextFormField(
                  controller: _themeController,
                  decoration:
                      InputDecoration(labelText: S.of(context).requiredSubject),
                  validator: _validateText,
                ),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: S.of(context).requiredMessage,
                  ),
                  validator: _validateText,
                  maxLines: 10,
                  minLines: 5,
                ),
                SizedBox(height: 20),
                BlocBuilder<FeedbackBloc, FeedbackState>(
                  cubit: feedbackBloc,
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        shadowColor: Colors.white.withOpacity(0),
                        splashFactory: NoSplash.splashFactory,
                        minimumSize: Size.fromHeight(45),
                        elevation: 0,
                      ),
                      onPressed: (state is FeedbackSendingMessage)
                          ? null
                          : _sendMessage,
                      child: Text(
                        S.of(context).submit.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateText(String value) {
    if (value.trim().isNotEmpty) {
      return null;
    }
    return S.current.fieldRequired;
  }

  String _emailValidator(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (emailValid) {
      return null;
    }
    return S.current.emailNotValid;
  }

  void _sendMessage() {
    if (_formKey.currentState.validate()) {
      feedbackBloc.add(SendMessageFeedback(
        fullName: _fullNameController.text,
        email: _emailController.text,
        message: _messageController.text,
        theme: _themeController.text,
      ));
    }
  }
}
