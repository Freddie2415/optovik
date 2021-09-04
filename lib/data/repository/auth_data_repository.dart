import 'dart:convert';

import 'package:optovik/data/api/response/login_response.dart';
import 'package:optovik/domain/model/user.dart';
import 'package:optovik/domain/repository/user_repository.dart';

class AuthDataRepository extends AuthRepository {
  @override
  Future<LoginResponse> authenticate({String username, String password}) async {
    final url = "${this.baseUrl}/api/token/";

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
      return LoginResponse(access: jsonResponse['access'] ?? '');
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
  Future<User> getUser(String access) async {
    final url = "${this.baseUrl}/api/v1/user/";
    print(url);
    Map<String, String> header = this.headers;
    header['Authorization'] = 'Bearer $access';
    final response = await this.client.get(url, headers: header);
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    print(response.statusCode);
    print(json);

    if (response.statusCode == 200) {
      var userList = jsonResponse['results'] as List;

      if (userList.isEmpty) {
        throw 'Пользователь не найден!';
      }
      var json = userList.first;

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
