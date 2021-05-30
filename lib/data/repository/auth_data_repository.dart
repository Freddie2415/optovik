import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:optovik/data/api/response/login_response.dart';
import 'package:optovik/domain/model/user.dart';
import 'package:optovik/domain/repository/user_repository.dart';

class AuthDataRepository extends AuthRepository {
  @override
  Future<LoginResponse> authenticate({String username, String password}) async {
    final url = "${this.baseUrl}/rest-auth/login/";

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    final response = await this.client.post(url,
        headers: {
          'Accept-Charset': 'utf-8',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: body);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    print(response.statusCode);
    print(jsonResponse);

    if (response.statusCode == 200) {
      return LoginResponse(
        key: jsonResponse['key'],
        user: jsonResponse['user'].toString(),
        userType: jsonResponse['user_type'],
      );
    } else {
      throw "Невозможно войти с предоставленными учетными данными.";
    }
  }

  @override
  Future<void> createUser() {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(String id) async {
    final url = "${this.baseUrl}/api/v1/user/$id/";
    print(url);
    final response = await this.client.get(url, headers: this.headers);
    var json = jsonDecode(utf8.decode(response.bodyBytes));

    print(response.statusCode);
    print(json);

    if (response.statusCode == 200) {
      return User(
        id: json['id'].toString(),
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        email: json['email'] as String,
        username: json['username'].toString(),
      );
    } else {
      throw 'Пользователь не найден!';
    }
  }

  @override
  Future<User> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
