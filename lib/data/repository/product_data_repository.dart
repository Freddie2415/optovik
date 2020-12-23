import 'package:optovik/data/api/api_utils.dart';
import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/data/api/response/products_response.dart';
import 'package:optovik/data/api/storage_utils.dart';
import 'package:optovik/domain/repository/product_repository.dart';

class ProductDataRepository extends ProductRepository {
  final ApiUtil _apiUtil;
  final StorageUtils _storageUtils;

  ProductDataRepository(this._apiUtil, this._storageUtils);

  @override
  Future<ProductsResponse> getProducts(ProductsParams params) async {
    if (params.search != null && params.search.isNotEmpty) {
      List<String> suggestions = await _storageUtils.getSearchSuggestions();

      suggestions.add(params.search);
      suggestions = suggestions.toSet().toList();

      print("suggestions.length: ${suggestions.length}");

      _storageUtils.setSearchSuggestions(suggestions);
    }

    return _apiUtil.getProducts(params);
  }

  @override
  Future<List<String>> getSearchSuggestions() async {
    return await _storageUtils.getSearchSuggestions();
  }

  @override
  Future<void> clearSearchSuggestions() async {
    return await _storageUtils.clearSearchSuggestions();
  }
}
