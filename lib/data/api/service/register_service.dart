import 'dart:convert';

import 'package:optovik/data/api/service/service.dart';

class RegisterService extends Service {
  Future<String> register({
    firstName,
    lastName,
    username,
    password,
  }) async {
    final url = "${this.baseUrl}/user/";
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
    final url = "${this.baseUrl}/sms_verify/$userId/";

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
}
