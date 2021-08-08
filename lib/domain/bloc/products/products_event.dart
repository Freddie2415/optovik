part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsFetched extends ProductsEvent {
  final Sort sort;
  final categoryId;
  final String query;
  final bool refresh;

  ProductsFetched({
    @required this.categoryId,
    @required this.sort,
    @required this.query,
    this.refresh = false,
  });

  @override
  List<Object> get props => [];

  get ordering => sort.toString();
}

class ProductsRefreshEvent extends ProductsEvent {}
