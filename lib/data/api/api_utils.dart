import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/data/api/response/home_response.dart';
import 'package:optovik/data/api/response/products_response.dart';
import 'package:optovik/data/api/service/category_service.dart';
import 'package:optovik/data/api/service/home_service.dart';
import 'package:optovik/data/api/service/product_service.dart';
import 'package:optovik/data/mapper/category_mapper.dart';
import 'package:optovik/domain/model/category.dart';

class ApiUtil {
  final CategoryService _categoryService;
  final ProductService _productService;
  final HomeService _homeService;

  ApiUtil(this._categoryService, this._productService, this._homeService);

  Future<List<Category>> getCategories() async {
    final result = await _categoryService.getCategories();
    return CategoryMapper.fromApiList(result);
  }

  Future<ProductsResponse> getProducts(ProductsParams params) async {
    return await _productService.getProducts(params);
  }

  Future<HomeResponse> getHomeData() async {
    return await _homeService.get();
  }

  Future<ProductsResponse> searchProducts(String query) async {
    return await _productService.search(query);
  }
}
