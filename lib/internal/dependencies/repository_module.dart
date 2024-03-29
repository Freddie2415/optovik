import 'package:optovik/data/repository/cart_data_repository.dart';
import 'package:optovik/data/repository/category_data_repository.dart';
import 'package:optovik/data/repository/home_data_repository.dart';
import 'package:optovik/data/repository/product_data_repository.dart';
import 'package:optovik/data/repository/auth_data_repository.dart';
import 'package:optovik/domain/repository/cart_repository.dart';
import 'package:optovik/domain/repository/category_repository.dart';
import 'package:optovik/domain/repository/home_repository.dart';
import 'package:optovik/domain/repository/product_repository.dart';
import 'package:optovik/domain/repository/user_repository.dart';
import 'package:optovik/internal/dependencies/api_module.dart';
import 'package:optovik/internal/dependencies/storage_module.dart';

class RepositoryModule {
  static CategoryRepository _categoryRepository;
  static ProductRepository _productRepository;
  static HomeRepository _homeRepository;
  static CartRepository _cartRepository;
  static AuthRepository _userRepository;

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
        StorageModule.storageUtil(),
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

  static CartRepository cartRepository() {
    if (_cartRepository == null) {
      _cartRepository = CartDataRepository(
        StorageModule.storageUtil(),
        ApiModule.apiUtil(),
      );
    }
    return _cartRepository;
  }

  static AuthRepository userRepository() {
    if (_userRepository == null) {
      _userRepository = AuthDataRepository();
    }
    return _userRepository;
  }
}
