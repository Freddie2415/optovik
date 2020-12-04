import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:optovik/data/api/request/products_params.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/domain/repository/product_repository.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  int nextPage = 1;
  final int _limit = 20;
  final categoryId;

  ProductsBloc(this._productRepository, this.categoryId)
      : super(ProductsInitial()) {
    this.add(ProductsFetched());
  }

  @override
  Stream<Transition<ProductsEvent, ProductsState>> transformEvents(
    Stream<ProductsEvent> events,
    TransitionFunction<ProductsEvent, ProductsState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  final ProductRepository _productRepository;

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    final currentState = state;
    if (event is ProductsFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ProductsInitial ||
            currentState is ProductsFailure) {
          final params = ProductsParams(
            limit: _limit,
            page: nextPage,
            categoryId: categoryId,
          );

          final result = await _productRepository.getProducts(params);
          final reachedMax = result.nextPage == null && result.nextUrl == null;

          yield ProductsSuccess(
            products: result.products,
            hasReachedMax: reachedMax,
          );
        }
        if (currentState is ProductsSuccess) {
          final params = ProductsParams(
            categoryId: categoryId,
            limit: _limit,
            page: ++nextPage,
          );

          final result = await _productRepository.getProducts(params);
          final products = result.products;
          final reachedMax = result.nextPage == null && result.nextUrl == null;

          yield products.isEmpty
              ? currentState.copyWith(hasReachedMax: reachedMax)
              : ProductsSuccess(
                  products: currentState.products + products,
                  hasReachedMax: reachedMax,
                );
        }
      } catch (e) {
        print(e);
        nextPage = 1;
        yield ProductsFailure(message: e.toString());
      }
    }
  }

  bool _hasReachedMax(ProductsState state) =>
      state is ProductsSuccess && state.hasReachedMax;
}
