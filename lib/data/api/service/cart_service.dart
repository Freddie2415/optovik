import 'dart:convert';

import 'package:optovik/domain/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String KEY_ORDERS = "orders";
  static const String KEY_POSTPONED = "postponed";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List> getOrders(String key) async {
    final prefs = await _prefs;
    final jsonOrders = prefs.getStringList(key) ?? [];
    final List orders = jsonOrders.map((e) => jsonDecode(e)).toList();

    print("getOrders $key : ${orders.length}");

    return orders;
  }

  Future<void> setCartItems(List<Product> currentOrder, String key) async {
    final SharedPreferences prefs = await _prefs;
    final orders = currentOrder
        .map((e) => jsonEncode({
              "id": e.id,
              "qty": e.qty,
              "postponed": e.postponed,
            }))
        .toList();

    print("setCartItems $key : ${orders.length}");

    await prefs.setStringList(key, orders);
  }
}
