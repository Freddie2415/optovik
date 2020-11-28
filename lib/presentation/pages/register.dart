import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Регистрация"),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(child: buildLoginForm(context)),
      ),
    );
  }

  Widget buildRegisterBtn(BuildContext context) {
    if (Platform.isAndroid) {
      return Container(
        width: double.infinity,
//        height: 45.0,
        child: OutlineButton(
          onPressed: () {},
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
        onPressed: () {},
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
          "ЗАРЕГИСТРИРОВАТЬСЯ".toUpperCase(),
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  void _loginEvent() async {}

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
                labelText: "Имя *",
              ),
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
                labelText: "Телефон или Email *",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return "Заполните поле *";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Пароль *",
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            buildLoginBtn(context),
          ],
        ),
      ),
    );
  }
}
