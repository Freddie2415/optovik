import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/model/product.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([], []));

  List<Product> currentOrder = [];
  List<Product> pendingOrder = [];

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is RemoveFromCurrentOrder) {
      currentOrder.removeWhere((p) => p.id == event.product.id);
    }

    if (event is PostponeAll) {
      pendingOrder.addAll(currentOrder);
      currentOrder.clear();
    }

    if (event is PostponeProduct) {
      if (currentOrder.any((element) => element.id == event.product.id)) {
        currentOrder.remove(event.product);
        pendingOrder.add(event.product);
      }
    }

    if (event is TransferToOrder) {
      currentOrder.addAll(pendingOrder);
      pendingOrder.clear();
    }

    if (event is FromPostponeToCart) {
      if (pendingOrder.any((element) => element.id == event.product.id)) {
        currentOrder.add(event.product);
        pendingOrder.remove(event.product);
      }
    }

    if (event is RemoveFromPostponed) {
      pendingOrder.removeWhere((element) => element == event.product);
    }

    if (event is ClearOrder) {
      currentOrder.clear();
    }

    if (event is ClearPendingOrder) {
      pendingOrder.clear();
    }

    if (event is ChangeProductCount) {
      int index = currentOrder.indexWhere((p) => p.id == event.product.id);
      if (index != -1) {
        currentOrder[index] = currentOrder[index].copyWith(qty: event.qty);
      } else {
        pendingOrder.remove(event.product);
        currentOrder.add(event.product);
      }
    }

    currentOrder = currentOrder.toSet().toList();
    pendingOrder = pendingOrder.toSet().toList();

    currentOrder.removeWhere((p) => p.qty == 0);
    pendingOrder.removeWhere((p) => p.qty == 0);

    yield CartState(currentOrder ?? [], pendingOrder ?? []);
  }
}
