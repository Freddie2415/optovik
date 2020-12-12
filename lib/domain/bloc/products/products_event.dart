part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsFetched extends ProductsEvent {
  final Sort sort;

  ProductsFetched({this.sort});

  @override
  List<Object> get props => [];

  get ordering => sort.toString();
}
