import 'dart:convert';

import 'package:http/http.dart';
import 'package:optovik/data/api/service/service.dart';
import 'package:optovik/domain/model/page.dart';

class InfoService extends Service {
  Future<List<Page>> getAll(String token) async {
    var headers = this.headers;

    headers['Authorization'] = "Bearer $token";

    final Response response = await this.client.get(
          "${this.baseUrl}/api/v1/pages",
          headers: headers,
        );

    if (response.statusCode >= 400) {
      throw Exception(response.body);
    }

    var json = jsonDecode(utf8.decode(response.bodyBytes));

    final pages = json['results'] as List;
    final List<Page> pageList = pages.map((item) {
      return Page(
        titleRu: item['title_ru'] ?? '',
        titleUz: item['title_uz'] ?? '',
        contentRu: item['content_ru'] ?? '',
        contentUz: item['content_uz'] ?? '',
        priority: item['priority'] ?? 0,
      );
    }).toList();

    return pageList;
  }
}
