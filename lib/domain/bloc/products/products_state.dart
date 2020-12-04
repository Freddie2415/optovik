part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsSuccess extends ProductsState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductsSuccess({
    this.products,
    this.hasReachedMax,
  });

  @override
  List<Object> get props => [products, hasReachedMax];

  ProductsSuccess copyWith({
    List<Product> products,
    bool hasReachedMax,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => 'ProductsSuccess {products: ${products.length}, hasReachedMax: $hasReachedMax }';
}

class ProductsFailure extends ProductsState {
  final String message;

  ProductsFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
