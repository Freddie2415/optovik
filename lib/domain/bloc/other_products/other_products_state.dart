part of 'other_products_bloc.dart';

abstract class OtherProductsState extends Equatable {
  const OtherProductsState();

  @override
  List<Object> get props => [];
}

class OtherProductsInitial extends OtherProductsState {}

class OtherProductsFetched extends OtherProductsState {
  final List<Product> products;

  OtherProductsFetched(this.products);
}

class OtherProductsLoading extends OtherProductsState {}
