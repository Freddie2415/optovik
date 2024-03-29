import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:optovik/data/api/request/products_params.dart';
import 'package:optovik/domain/model/sort_type.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/domain/repository/product_repository.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;
  final int _limit = 20;
  int nextPage = 1;
  String ordering = Sort().toString();

  ProductsBloc({
    @required this.productRepository,
  })  : assert(productRepository != null),
        super(ProductsInitial());

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

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    final currentState = state;
    if (event is ProductsFetched) {
      final bool orderingChanged =
          event.sort != null && event.ordering != this.ordering;
      try {
        if (orderingChanged || event.refresh) {
          yield* _initialFetch(event);
          return;
        }
        if (!_hasReachedMax(currentState)) {
          if (currentState is ProductsInitial ||
              currentState is ProductsFailure) {
            yield* _initialFetch(event);
          } else if (currentState is ProductsSuccess) {
            yield* _pagination(currentState, event.categoryId, event.query);
          }
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

  Stream<ProductsState> _initialFetch(ProductsFetched event) async* {
    this.ordering = event.ordering;
    yield ProductsLoading();

    this.nextPage = 1;
    final params = ProductsParams(
      limit: _limit,
      page: nextPage,
      categoryId: event.categoryId,
      ordering: this.ordering,
      search: event.query,
    );

    final result = await productRepository.getProducts(params);
    final reachedMax = result.nextPage == null && result.nextUrl == null;

    yield ProductsSuccess(
      products: result.products,
      hasReachedMax: reachedMax,
    );
  }

  Stream<ProductsState> _pagination(
      ProductsSuccess currentState, categoryId, search) async* {
    final params = ProductsParams(
      categoryId: categoryId,
      limit: _limit,
      page: ++nextPage,
      ordering: this.ordering,
      search: search,
    );

    final result = await productRepository.getProducts(params);
    final products = result.products;
    final reachedMax = result.nextPage == null && result.nextUrl == null;

    yield products.isEmpty
        ? currentState.copyWith(hasReachedMax: reachedMax)
        : ProductsSuccess(
            products: currentState.products + products,
            hasReachedMax: reachedMax,
          );
  }
}
