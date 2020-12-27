part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInit extends CartEvent {}

class RemoveFromCurrentOrder extends CartEvent {
  final Product product;

  RemoveFromCurrentOrder(this.product);

  @override
  List<Object> get props => [product];
}

class ChangeProductCount extends CartEvent {
  final Product product;
  final int qty;

  ChangeProductCount(this.product, [this.qty = 0]);

  ChangeProductCount copyWith({int qty}) {
    return ChangeProductCount(product, qty);
  }

  @override
  String toString() => 'product: $product qty: $qty';
}

class PostponeProduct extends CartEvent {
  final Product product;

  PostponeProduct(this.product);
}

class RemoveFromPostponed extends CartEvent {
  final Product product;

  RemoveFromPostponed(this.product);
}

class FromPostponeToCart extends CartEvent {
  final Product product;

  const FromPostponeToCart(this.product);
}

class PostponeAll extends CartEvent {}

class TransferToOrder extends CartEvent {}

class ClearOrder extends CartEvent {}

class ClearPendingOrder extends CartEvent {}
