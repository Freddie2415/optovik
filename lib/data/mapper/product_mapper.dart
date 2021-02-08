import 'dart:convert';

import 'package:optovik/data/api/model/api_product.dart';
import 'package:optovik/data/mapper/category_mapper.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductMapper {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<List<Product>> fromApiList(List<ApiProduct> list) async {
    final List<Product> products = list
        .map(
          (e) => Product(
              id: e.id,
              status: e.status,
              showPrice: e.showPrice,
              short: e.short,
              price: e.price,
              model: e.model,
              manufacturer: e.manufacturer,
              lastPriceUpdate: e.lastPriceUpdate,
              keywords: e.keywords,
              isHost: e.isHost,
              inStock: e.inStock,
              guaranty: e.guaranty,
              discountType: e.discountType,
              discount: e.discount,
              description: e.description,
              created: e.created,
              count: e.count,
              article: e.article,
              title: e.title,
              images: e.photos,
              unit: '',
              categories: CategoryMapper.fromApiList(e.categories)),
        )
        .toList();

    return await _fromStorageList(products);
  }

  static _fromStorageList(List<Product> apiProducts) async {
    final prefs = await _prefs;
    final jsonOrders = prefs.getStringList("orders") ?? [];
    final orders = jsonOrders.map((e) => jsonDecode(e)).toList();
    for (var value in orders) {
      if (value != null &&
          value['id'] != null &&
          apiProducts.any((p) => p.id == value['id'])) {
        int index = apiProducts.indexWhere((p) => p.id == value['id']);
        apiProducts[index] = apiProducts[index].copyWith(
          qty: value['qty'],
          postponed: value['postponed'],
        );
      }
    }

    return apiProducts;
  }
}
