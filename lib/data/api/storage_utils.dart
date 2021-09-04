import 'package:optovik/data/api/service/cart_service.dart';
import 'package:optovik/data/api/service/search_suggestion_service.dart';
import 'package:optovik/domain/model/product.dart';

class StorageUtils {
  final SearchSuggestionService _searchSuggestionService;
  final CartService _cartService;

  StorageUtils(this._searchSuggestionService, this._cartService);

  Future<void> setSearchSuggestions(List<String> list) async {
    await _searchSuggestionService.setSuggestions(list);
  }

  Future<List<String>> getSearchSuggestions() async {
    return await _searchSuggestionService.getSuggestions();
  }

  Future<void> clearSearchSuggestions() async {
    await _searchSuggestionService.clearSuggestions();
  }

  Future<List> getCartItems() async {
    return await _cartService.getOrders(CartService.KEY_ORDERS);
  }

  Future<List> getPostponedItems() async {
    return await _cartService.getOrders(CartService.KEY_POSTPONED);
  }

  Future<void> setCartItems(List<Product> currentOrder) async {
    await _cartService.setCartItems(currentOrder, CartService.KEY_ORDERS);
  }

  Future<void> setPostponedItems(List<Product> currentOrder) async {
    await _cartService.setCartItems(currentOrder, CartService.KEY_POSTPONED);
  }
}
