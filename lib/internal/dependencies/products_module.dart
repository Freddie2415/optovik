import 'package:optovik/domain/bloc/products/products_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';

class ProductsModule {
  static ProductsBloc productsBloc(categoryId) {
    return ProductsBloc(RepositoryModule.productRepository(),categoryId);
  }
}
