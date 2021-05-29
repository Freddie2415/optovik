import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:optovik/data/api/model/api_category.dart';

class CategoryService {
  static const _BASE_URL = 'http://optovikuz.com/api/v1';

  final http.Client _client = http.Client();

  final Map<String, String> _headers = {
    'Authorization': 'Basic YWRtaW46YWRtaW5hZG1pbg==',
    'Accept-Charset': 'utf-8',
  };

  Future<List<ApiCategory>> getCategories() async {
    final response = await _client.get(
      "$_BASE_URL/categories/?format=json&limit=1000",
      headers: _headers,
    );

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    var items = jsonResponse['results'] as List;

    return ApiCategory.fromArrayApi(items);
  }
}
