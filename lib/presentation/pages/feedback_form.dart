import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/feedback/feedback_bloc.dart';
import 'package:optovik/internal/dependencies/feedback_module.dart';

class FeedbackFormPage extends StatelessWidget {
  static Route<Object> route() {
    return MaterialPageRoute(builder: (context) => FeedbackFormPage());
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FeedbackBloc _feedbackBloc = FeedbackModule.feedbackBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Письмо в тех. поддержку'),
      ),
      body: BlocListener(
        cubit: _feedbackBloc,
        listener: (context, state) {
          if (state is FeedbackMessageSent) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  backgroundColor: Colors.lightGreen,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ваше сообщение отправлено".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.check, color: Colors.white)
                    ],
                  )));
            _formKey.currentState.reset();
          }
          if (state is FeedbackFailure) {
            Scaffold.of(context)
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
            Scaffold.of(context).hideCurrentSnackBar();
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
                  decoration: InputDecoration(labelText: "Имя *"),
                  validator: _validateText,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email *"),
                  validator: _emailValidator,
                ),
                TextFormField(
                  controller: _themeController,
                  decoration: InputDecoration(labelText: "Тема сообщения *"),
                  validator: _validateText,
                ),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: "Текст cообщения *",
                  ),
                  validator: _validateText,
                  maxLines: 10,
                  minLines: 5,
                ),
                SizedBox(height: 20),
                BlocBuilder<FeedbackBloc, FeedbackState>(
                  cubit: _feedbackBloc,
                  builder: (context, state) {
                    return FlatButton(
                      onPressed: (state is FeedbackInitial || state is FeedbackFailure) ? _sendMessage : null ,
                      height: 45,
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "ОТПРАВИТЬ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.lightGreen,
                      textColor: Colors.white,
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
    return "Заполните поле";
  }

  String _emailValidator(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (emailValid) {
      return null;
    }
    return "Не валидный Email";
  }

  void _sendMessage() {
    if (_formKey.currentState.validate()) {
      _feedbackBloc.add(SendMessageFeedback(
        fullName: _fullNameController.text,
        email: _emailController.text,
        message: _messageController.text,
        theme: _themeController.text,
      ));
    }
  }
}
