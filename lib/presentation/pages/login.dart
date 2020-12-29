import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/login/login_bloc.dart';
import 'package:optovik/domain/model/auth_status.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/presentation/pages/home.dart';
import 'package:optovik/presentation/pages/register.dart';

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

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Авторизация"),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(child: buildLoginForm(context)),
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
            Navigator.pushReplacement(context, HomePage.route());
          },
        ),
      ),
    );
  }

  Widget buildRegisterBtn(BuildContext context) {
    if (Platform.isAndroid) {
      return Container(
        width: double.infinity,
//        height: 45.0,
        child: OutlineButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Register(),
              ),
            );
          },
          color: Colors.lightGreen,
          highlightedBorderColor: Colors.lightGreen,
          splashColor: Colors.lightGreen,
          child: Text(
            "Зарегистрироваться".toUpperCase(),
            style: TextStyle(
              fontSize: 16.0,
              // color: kSecondaryColor,
            ),
          ),
        ),
      );
    } else {
      return CupertinoButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(),
            ),
          );
        },
        child: Text(
          "Зарегистрироваться".toUpperCase(),
          style: TextStyle(
            fontSize: 16.0,
            // color: kSecondaryColor,
          ),
        ),
      );
    }
  }

  Widget buildLoginBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: CupertinoButton(
        onPressed: _loginEvent,
        color: Colors.lightGreen,
        child: Text(
          "Войти".toUpperCase(),
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  void _loginEvent() async {
    if (_formKey.currentState.validate()) {}
  }

  Widget buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: MediaQuery.of(context).size.height * .20,
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Заполните поле";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return "Заполните поле";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Пароль",
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            buildLoginBtn(context),
            buildRegisterBtn(context)
          ],
        ),
      ),
    );
  }

  void _authBlocListener(BuildContext context, AuthState state) {
    switch (state.status) {
      case AuthenticationStatus.unknown:
        break;
      case AuthenticationStatus.authenticated:
        Navigator.pushReplacement(context, HomePage.route());
        break;
      case AuthenticationStatus.unauthenticated:
        break;
/*      case AuthenticationStatus.error:
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text("${state.message}")));
        break;*/
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Register(),
              ),
            );
          },
          child: _text,
        ),
      );
    } else {
      return CupertinoButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(),
            ),
          );
        },
        child: _text,
      );
    }
  }
}
