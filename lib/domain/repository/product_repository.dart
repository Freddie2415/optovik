import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/data/api/response/products_response.dart';

abstract class ProductRepository {
  Future<ProductsResponse> getProducts(ProductsParams params);
}
