import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:optovik/data/api/model/api_support_number.dart';

class FeedbackService {
  Future<List<SupportNumber>> getFeedback() async {
    final response =
        await http.get("http://optovikuz.com/api/v1/support_number");

    if (response.statusCode >= 400) {
      throw "Что то пошло не так!";
    }

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final list = jsonResponse['results'] as List;

    return List.of(list)
        .map((e) => SupportNumber(
              id: e['id'],
              phone: e['phone'],
            ))
        .toList();
  }

  Future<void> sendMessage({
    @required String theme,
    @required String email,
    @required String message,
    @required String fullName,
  }) async {
    await Future.delayed(Duration(seconds: 1));
  }
}
