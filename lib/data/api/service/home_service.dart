import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:optovik/data/api/model/api_category.dart';
import 'package:optovik/data/api/model/api_product.dart';
import 'package:optovik/data/api/model/api_slider.dart';
import 'package:optovik/data/api/response/home_response.dart';
import 'package:optovik/data/mapper/category_mapper.dart';
import 'package:optovik/data/mapper/product_mapper.dart';
import 'package:optovik/data/mapper/slider_mapper.dart';

class HomeService {
  static const _BASE_URL = 'zender.uz';

  final http.Client _client = http.Client();

  final Map<String, String> _headers = {
    'Authorization': 'Basic YWRtaW46YWRtaW5hZG1pbg==',
    'Accept-Charset': 'utf-8',
  };

  Future<HomeResponse> get() async {
    final url = Uri.http(
      _BASE_URL,
      '/api/v1/home/',
    );

    final response = await _client.get(url, headers: _headers);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      final slidersData = jsonResponse['sliders'] as List;
      final hotDealsData = jsonResponse['hot_deals'] as List;
      final categoriesData = jsonResponse['categories'] as List;
      final hotProductsData = jsonResponse['hot_products'] as List;
      final lastProductsData = jsonResponse['last_products'] as List;

      final sliders = ApiSlider.fromApi(slidersData);
      final categories = ApiCategory.fromApiHome(categoriesData);
      final hotDeals = ApiProduct.fromApi(hotDealsData);
      final hotProducts = ApiProduct.fromApi(hotProductsData);
      final lastProducts = ApiProduct.fromApi(lastProductsData);

      return HomeResponse(
        banners: SliderMapper.fromApiList(sliders),
        categories: CategoryMapper.fromApiList(categories),
        hotDeals: ProductMapper.fromApiList(hotDeals),
        hotProducts: ProductMapper.fromApiList(hotProducts),
        lastProducts: ProductMapper.fromApiList(lastProducts),
      );
    } else {
      throw Exception('Ошибка при получении товаров');
    }
  }
}
