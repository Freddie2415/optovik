import 'package:optovik/domain/bloc/other_products/other_products_bloc.dart';
import 'package:optovik/domain/bloc/products/products_bloc.dart';
import 'package:optovik/domain/bloc/search_sugesstions/search_suggestions_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';

class ProductsModule {
  static ProductsBloc productsBloc() {
    return ProductsBloc(
      productRepository: RepositoryModule.productRepository(),
    );
  }

  static OtherProductsBloc otherProductsBloc() {
    return OtherProductsBloc(RepositoryModule.productRepository());
  }

  static SearchSuggestionsBloc searchSuggestionBloc(){
    return SearchSuggestionsBloc(RepositoryModule.productRepository());
  }
}
