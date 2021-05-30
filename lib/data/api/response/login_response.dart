import 'package:meta/meta.dart';

class LoginResponse {
  final String key;
  final String user;
  final String userType;

  LoginResponse({
    @required this.key,
    @required this.user,
    @required this.userType,
  });
}
