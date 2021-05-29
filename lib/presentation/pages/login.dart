import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/login/login_bloc.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/internal/dependencies/register_module.dart';
import 'package:optovik/presentation/pages/home.dart';
import 'package:optovik/presentation/pages/register.dart';
import 'package:optovik/presentation/pages/verification.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: BlocListener<AuthBloc, AuthState>(
            cubit: AuthModule.authBloc(),
            listener: _authBlocListener,
            child: BlocProvider(
              create: (_) => AuthModule.loginBloc(),
              child: LoginForm(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: FlatButton(
          color: Colors.lightGreen,
          height: 50,
          child: Text(
            "ПРОПУСТИТЬ",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              HomePage.route(),
            );
          },
        ),
      ),
    );
  }

  void _authBlocListener(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      Navigator.pushReplacement(context, HomePage.route());
    }
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _loginBlocListener,
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/images/logo.png'),
            width: MediaQuery.of(context).size.height * .20,
          ),
          _UsernameInput(),
          const SizedBox(height: 15.0),
          _PasswordInput(),
          const SizedBox(height: 15.0),
          _LoginButton(),
          const SizedBox(height: 15.0),
          _RegisterButton(),
        ],
      ),
    );
  }

  void _loginBlocListener(BuildContext context, LoginState state) {
    if (state.status.isSubmissionFailure) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('${state.failureMessage}')),
        );
    }
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText:
                state.username.invalid ? 'Поле не должно быть пустым' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Пароль',
            errorText:
                state.password.invalid ? 'Поле не должно быть пустым' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                height: 45,
                child: RaisedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  onPressed: state.status.isValidated
                      ? () =>
                          context.read<LoginBloc>().add(const LoginSubmitted())
                      : null,
                  color: Colors.lightGreen,
                  child: Text(
                    "Войти".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _text = Text(
      "Зарегистрироваться".toUpperCase(),
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
    if (!Platform.isAndroid) {
      return Container(
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            // ignore: close_sinks
            final bloc = await RegisterModule.getRegisterBloc();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Register(bloc),
              ),
            );
          },
          child: _text,
        ),
      );
    } else {
      return CupertinoButton(
        onPressed: () async {
          // ignore: close_sinks
          final bloc = await RegisterModule.getRegisterBloc();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(bloc),
            ),
          );
        },
        child: _text,
      );
    }
  }
}
