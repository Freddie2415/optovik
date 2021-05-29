import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:optovik/data/api/model/api_product.dart';
import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/data/api/response/products_response.dart';
import 'package:optovik/data/mapper/product_mapper.dart';

class ProductService {
  static const _HOST = 'optovikuz.com';
  static const _SCHEME = 'http';

  final http.Client _client = http.Client();

  final Map<String, String> _headers = {
    'Authorization': 'Basic YWRtaW46YWRtaW5hZG1pbg==',
    'Accept-Charset': 'utf-8',
  };

  Future<ProductsResponse> getProducts(ProductsParams params) async {
    final url = Uri(
      scheme: _SCHEME,
      host: _HOST,
      path: '/api/v1/products/',
      queryParameters: params.toRequestParams(),
    );

    final response = await _client.get(url, headers: _headers);
    print(url);

    return await _toProductResponse(response);
  }

  Future<ProductsResponse> search(String query) async {
    final params = {"search": query};
    final url = Uri.http(
      _HOST,
      'api/v1/products',
      params,
    );

    final response = await _client.get(url, headers: _headers);
    print(url);

    return _toProductResponse(response);
  }

  Future<ProductsResponse> _toProductResponse(http.Response response) async {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      var items = jsonResponse['results'] as List;

      final products =
          await ProductMapper.fromApiList(ApiProduct.fromApi(items));

      return ProductsResponse(
        nextPage: jsonResponse['next_page'],
        nextUrl: jsonResponse['next'],
        products: products,
      );
    } else {
      throw Exception('Ошибка при получении товаров');
    }
  }
}
