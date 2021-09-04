import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/login/login_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/internal/dependencies/register_module.dart';
import 'package:optovik/presentation/pages/home.dart';
import 'package:optovik/presentation/pages/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(this._loginBloc, this._authBloc, {Key key}) : super(key: key);

  static Route route({LoginBloc loginBloc, AuthBloc authBloc}) {
    return MaterialPageRoute<void>(
        builder: (_) => LoginPage(loginBloc, authBloc));
  }

  final LoginBloc _loginBloc;
  final AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).authorization)),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: BlocListener<AuthBloc, AuthState>(
            cubit: _authBloc,
            listener: _authBlocListener,
            child: BlocProvider(
              create: (_) => _loginBloc,
              child: LoginForm(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            S.of(context).skip,
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
    print("LOG: $state");
    if (state is AuthAuthenticated) {
      Navigator.pushReplacement(context, HomePage.route());
    }
    if (state is AuthFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("${state.message}")));
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
      ScaffoldMessenger.of(context)
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
          keyboardType: TextInputType.phone,
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: S.of(context).phone,
            errorText:
                state.username.invalid ? S.of(context).fieldRequired : null,
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
            labelText: S.of(context).password,
            errorText:
                state.password.invalid ? S.of(context).fieldRequired : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      cubit: AuthModule.authBloc(),
      builder: (context, state) {
        return state is AuthLoading
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                height: 45,
                child: CupertinoButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  color: Colors.indigo,
                  onPressed: () {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  },
                  child: Text(
                    S.of(context).login.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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
      S.of(context).register.toUpperCase(),
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
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
