import 'package:optovik/data/repository/category_data_repository.dart';
import 'package:optovik/domain/repository/category_repository.dart';
import 'package:optovik/internal/dependencies/api_module.dart';

class RepositoryModule {
  static CategoryRepository _categoryRepository;

  static CategoryRepository categoryRepository() {
    if (_categoryRepository == null) {
      _categoryRepository = new CategoryDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _categoryRepository;
  }
}
