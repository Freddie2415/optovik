import 'package:optovik/data/repository/category_data_repository.dart';
import 'package:optovik/data/repository/home_data_repository.dart';
import 'package:optovik/data/repository/product_data_repository.dart';
import 'package:optovik/domain/repository/category_repository.dart';
import 'package:optovik/domain/repository/home_repository.dart';
import 'package:optovik/domain/repository/product_repository.dart';
import 'package:optovik/internal/dependencies/api_module.dart';

class RepositoryModule {
  static CategoryRepository _categoryRepository;
  static ProductRepository _productRepository;
  static HomeRepository _homeRepository;

  static CategoryRepository categoryRepository() {
    if (_categoryRepository == null) {
      _categoryRepository = new CategoryDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _categoryRepository;
  }

  static ProductRepository productRepository() {
    if (_productRepository == null) {
      _productRepository = new ProductDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _productRepository;
  }

  static HomeRepository homeRepository() {
    if (_homeRepository == null) {
      _homeRepository = new HomeDataRepository(ApiModule.apiUtil());
    }
    return _homeRepository;
  }
}
