part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCurrentOrder extends CartEvent {
  final Product product;

  const AddToCurrentOrder(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromCurrentOrder extends CartEvent {
  final id;

  RemoveFromCurrentOrder(this.id);

  @override
  List<Object> get props => [id];
}

class ChangeProductCount extends CartEvent {
  final id;
  final int qty;

  ChangeProductCount(this.id, [this.qty = 0]);

  ChangeProductCount copyWith({int qty}) {
    return ChangeProductCount(id, qty);
  }
}

class PostponeProduct extends CartEvent {
  final id;

  PostponeProduct(this.id);
}

class RemoveFromPostponed extends CartEvent{
  final id;

  RemoveFromPostponed(this.id);
}

class FromPostponeToCart extends CartEvent {
  final id;

  const FromPostponeToCart(this.id);
}

class PostponeAll extends CartEvent {}

class TransferToOrder extends CartEvent {}

class ClearOrder extends CartEvent {}

class ClearPendingOrder extends CartEvent {}
