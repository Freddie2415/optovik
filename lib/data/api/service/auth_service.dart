import 'dart:convert';

import 'package:optovik/data/api/response/login_response.dart';
import 'package:optovik/data/api/service/service.dart';
import 'package:optovik/domain/model/user.dart';
import 'package:optovik/domain/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends Service {
  final AuthRepository _authRepository;
  final Future<SharedPreferences> _prefs;
  static const String SECRET_KEY = 'key';
  static const String USER_KEY = 'user';

  AuthService(this._authRepository, this._prefs);

  Future<String> register({
    firstName,
    lastName,
    username,
    password,
  }) async {
    final url = "${this.baseUrl}/api/v1/user/";
    final body = jsonEncode({
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName
    });

    final response =
        await this.client.post(url, headers: this.headers, body: body);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    print(jsonResponse);

    if (response.statusCode == 400) {
      return jsonResponse['username'][0];
    }

    if (response.statusCode == 201 && jsonResponse['id'] != null) {
      return jsonResponse['id'].toString();
    } else {
      throw "Ошибка регистрации!";
    }
  }

  Future<bool> verify(String smsCode, String userId) async {
    final url = "${this.baseUrl}/api/v1/sms_verify/$userId/";

    final body = jsonEncode({'sms_code': smsCode});

    final response =
        await this.client.post(url, headers: this.headers, body: body);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    bool userActivated =
        jsonResponse['is_active'] != null && jsonResponse['is_active'] == true;

    print(jsonResponse);
    if (response.statusCode == 200) {
      return userActivated;
    } else {
      throw Exception('Что то пошло не так!');
    }
  }

  Future<User> login(String username, String password) async {
    final LoginResponse response = await _authRepository.authenticate(
      username: username,
      password: password,
    );
    await _prefs.then((value) => value.setString(SECRET_KEY, response.access));

    final User user = await _authRepository.getUser(response.access);
    await _prefs.then(
      (value) => value.setString(
        USER_KEY,
        jsonEncode(user.toJson()),
      ),
    );

    return user;
  }

  Future<void> logout() async {
    await _prefs.then((value) => value.remove(SECRET_KEY));
    await _prefs.then((value) => value.remove(USER_KEY));
  }

  Future<bool> hasToken() {
    return _prefs.then((value) => value.containsKey(SECRET_KEY));
  }

  Future<String> getToken() async {
    return _prefs.then((value) => value.getString(SECRET_KEY));
  }

  Future getUser() async {
    if (!await _prefs.then((value) => value.containsKey(SECRET_KEY))) {
      throw 'Пользователь не авторизован!';
    }

    return await _authRepository.getUser(await getToken());
  }
}
