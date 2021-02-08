import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:optovik/data/api/response/auth_response.dart';

class UserService {
  final http.Client _client = http.Client();

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<AuthResponse> authenticate({
    @required String username,
    @required String password,
  }) async {
    final url = 'http://zender.uz/rest-auth/login/';

    try {
      var response = await _client.post(
        url,
        body: jsonEncode({'username': username, 'password': password}),
        headers: _headers,
      );

      Map json = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(json);
      } else {
        throw "Невозможно войти с предоставленными учетными данными";
      }
    } catch (e) {
      print(e);
      throw "Проверьте подключение к интернету";
    }
  }
}
