part of 'other_products_bloc.dart';

abstract class OtherProductsEvent extends Equatable {
  const OtherProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchOtherProducts extends OtherProductsEvent {
  final categoryId;

  final currentProductId;

  FetchOtherProducts(this.categoryId, this.currentProductId);
}
