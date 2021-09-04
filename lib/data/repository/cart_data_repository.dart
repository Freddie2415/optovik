import 'package:optovik/data/api/api_utils.dart';
import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/data/api/response/products_response.dart';
import 'package:optovik/data/api/storage_utils.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/domain/repository/cart_repository.dart';

class CartDataRepository extends CartRepository {
  final StorageUtils _storageUtils;
  final ApiUtil _apiUtil;

  CartDataRepository(this._storageUtils, this._apiUtil);

  @override
  Future<List<Product>> getOrderItems() async {
    final List orders = await _storageUtils.getCartItems();
    if (orders.isEmpty) {
      print("orders.isEmpty");
      return [];
    }
    print("orders length: ${orders.length}");

    ProductsParams requestParams = ProductsParams(limit: 100, page: 1);
    orders.forEach((element) => requestParams.addParameterId(element['id']));
    final ProductsResponse res = await _apiUtil.getProducts(requestParams);

    return res.products;
  }

  @override
  Future<List<Product>> getPostponedItems() async {
    final List orders = await _storageUtils.getPostponedItems();
    if (orders.isEmpty) {
      print("orders.isEmpty");
      return [];
    }
    print("orders length: ${orders.length}");

    ProductsParams requestParams = ProductsParams(limit: 100, page: 1);
    orders.forEach((element) => requestParams.addParameterId(element['id']));
    final ProductsResponse res = await _apiUtil.getProducts(requestParams);

    return res.products.map((e) {
      if (e.qty == 0) {
        return e.copyWith(qty: 1);
      }
      return e;
    }).toList();
  }

  @override
  Future<void> setOrderItems(List<Product> currentOrder) async {
    await _storageUtils.setCartItems(currentOrder);
  }

  @override
  Future<void> setPostponedItems(List<Product> currentOrder) async {
    await _storageUtils.setPostponedItems(currentOrder);
  }
}
