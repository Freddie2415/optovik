import 'package:optovik/domain/model/product.dart';

abstract class CartRepository {
  Future<List<Product>> getOrderItems();

  Future<void> setOrderItems(List<Product> currentOrder);
}
