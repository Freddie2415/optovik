import 'package:optovik/domain/bloc/categories/categories_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';

class CategoriesModule {
  static CategoriesBloc categoriesBloc() {
    return CategoriesBloc(RepositoryModule.categoryRepository());
  }
}
