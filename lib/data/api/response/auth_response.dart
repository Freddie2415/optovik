import 'package:meta/meta.dart';

class AuthResponse {
  final String key;
  final int user;
  final String userType;

  AuthResponse({
    @required this.key,
    @required this.user,
    @required this.userType,
  });

  factory AuthResponse.fromJson(Map<dynamic, dynamic> json) {
    return AuthResponse(
      key: json['key'],
      user: json['user'],
      userType: json['user_type'],
    );
  }
}
