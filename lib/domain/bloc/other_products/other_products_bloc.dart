import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/domain/repository/product_repository.dart';

part 'other_products_event.dart';

part 'other_products_state.dart';

class OtherProductsBloc extends Bloc<OtherProductsEvent, OtherProductsState> {
  final ProductRepository _productRepository;

  OtherProductsBloc(this._productRepository) : super(OtherProductsInitial());

  @override
  Stream<OtherProductsState> mapEventToState(
    OtherProductsEvent event,
  ) async* {
    if (event is FetchOtherProducts) {
      yield OtherProductsLoading();

      try {
        final response = await this._productRepository.getProducts(
                  ProductsParams(limit: 21, page: 1, categoryId: event.categoryId));
        List<Product> products = response.products
                  .where((element) => element.id != event.currentProductId)
                  .toList();

        yield OtherProductsFetched(products);
      } catch (e) {
        print(e);
      }
    }
  }
}
