part of 'cart_bloc.dart';

class CartState{
  final List<Product> orders;
  final List<Product> postponed;

  const CartState(this.orders, this.postponed);
}