import 'dart:convert';

import 'package:optovik/domain/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String _KEY = "orders";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List> getOrders() async {
    final prefs = await _prefs;
    final jsonOrders = prefs.getStringList(_KEY) ?? [];
    final List orders = jsonOrders.map((e) => jsonDecode(e)).toList();

    print("getOrders $_KEY : ${orders.length}");

    return orders;
  }

  Future<void> setCartItems(List<Product> currentOrder) async {
    final SharedPreferences prefs = await _prefs;
    final orders = currentOrder
        .map((e) => jsonEncode({
              "id": e.id,
              "qty": e.qty,
              "postponed": e.postponed,
            }))
        .toList();

    print("setCartItems $_KEY : ${orders.length}");

    await prefs.setStringList(_KEY, orders);
  }
}
