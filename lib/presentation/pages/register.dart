import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/register/register_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/pages/verification.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final RegisterBloc _registerBloc;
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();

  Register(this._registerBloc, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).registration),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: BlocListener(
          listener: _registerBlogListener,
          child: SingleChildScrollView(child: buildRegisterForm(context)),
          cubit: _registerBloc,
        ),
      ),
    );
  }

  Widget buildRegisterBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: CupertinoButton(
        onPressed: _registerEvent,
        color: Colors.indigo,
        child: Text(
          S.of(context).register.toUpperCase(),
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildRegisterForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _firstNameController,
              validator: _inputValidator,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: S.of(context).name),
            ),
            TextFormField(
              controller: _lastNameController,
              validator: _inputValidator,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: S.of(context).lastName),
            ),
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.phone,
              validator: _inputValidator,
              decoration: InputDecoration(labelText: S.of(context).phoneNumber),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: _inputValidator,
              decoration: InputDecoration(labelText: S.of(context).password),
            ),
            SizedBox(
              height: 20.0,
            ),
            buildRegisterBtn(context),
          ],
        ),
      ),
    );
  }

  String _inputValidator(String value) {
    if (value.isEmpty) {
      return S.current.fieldRequired;
    }
    return null;
  }

  void _registerEvent() async {
    bool valid =
        _formKey.currentState != null && _formKey.currentState.validate();
    if (valid) {
      this._registerBloc.add(TryRegisterEvent(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            username: _usernameController.text,
            password: _passwordController.text,
          ));
    }
  }

  void _registerBlogListener(BuildContext context, state) {
    if (state is RegisterSMSVerifyState) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(
            this._registerBloc,
            phone: state.phone,
          ),
        ),
      );
      return;
    }
    if (state is RegisterFailureState) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("${state.message}")));
      return;
    }
  }
}
