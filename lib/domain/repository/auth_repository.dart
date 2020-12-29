import 'dart:async';

import 'package:meta/meta.dart';
import 'package:optovik/domain/model/auth_status.dart';

abstract class AuthRepository {
  Stream<AuthenticationStatus> get status;

  Future<void> logIn({
    @required String username,
    @required String password,
  });

  void logOut();

  void dispose();
}
