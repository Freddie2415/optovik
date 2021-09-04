import 'package:optovik/domain/model/product.dart';

abstract class CartRepository {
  Future<List<Product>> getOrderItems();

  Future<List<Product>> getPostponedItems();

  Future<void> setOrderItems(List<Product> currentOrder);

  Future<void> setPostponedItems(List<Product> currentOrder);
}
