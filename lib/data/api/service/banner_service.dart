import 'dart:convert';

import 'package:optovik/data/api/response/banner_response.dart';
import 'package:optovik/data/api/service/service.dart';

class BannerService extends Service {
  Future<List<BannerResponse>> getBanners() async {
    final response = await this.client.get(
          "${this.baseUrl}/api/v1/banners",
          headers: this.headers,
        );

    var json = jsonDecode(utf8.decode(response.bodyBytes));
    print(response.statusCode);
    print(json);

    if (response.statusCode == 200) {
      var items = json['results'] as List;
      final bannerList = items.map((e) {
        return BannerResponse(
          id: e['id'],
          photo: e['photo'],
          link: e['link'],
          adType: e['adType'],
        );
      }).toList();

      return bannerList;
    } else {
      throw "С баннерами, что то пошло не так";
    }
  }
}
