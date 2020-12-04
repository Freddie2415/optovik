import 'package:optovik/data/api/api_utils.dart';
import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/data/api/response/products_response.dart';
import 'package:optovik/domain/repository/product_repository.dart';

class ProductDataRepository extends ProductRepository {
  final ApiUtil _apiUtil;

  ProductDataRepository(this._apiUtil);

  @override
  Future<ProductsResponse> getProducts(ProductsParams params) async {
    return _apiUtil.getProducts(params);
  }
}
