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
    if (event is AddToCurrentOrder) {
      currentOrder.add(event.product.copyWith(qty: 1));
    }

    if (event is RemoveFromCurrentOrder) {
      currentOrder.removeWhere((p) => p.id == event.id);
    }

    if (event is PostponeAll) {
      pendingOrder.addAll(currentOrder);
      currentOrder.clear();
    }

    if (event is PostponeProduct) {
      final product =
          currentOrder.firstWhere((element) => element.id == event.id);
      if (product != null) {
        currentOrder.remove(product);
        pendingOrder.add(product);
      }
    }

    if (event is TransferToOrder) {
      currentOrder.addAll(pendingOrder);
      pendingOrder.clear();
    }

    if (event is FromPostponeToCart) {
      final product =
          pendingOrder.firstWhere((element) => element.id == event.id);
      if (product != null) {
        currentOrder.add(product);
        pendingOrder.remove(product);
      }
    }

    if (event is RemoveFromPostponed) {
      pendingOrder.removeWhere((element) => element.id == event.id);
    }

    if (event is ClearOrder) {
      currentOrder.clear();
    }

    if (event is ClearPendingOrder) {
      pendingOrder.clear();
    }

    if (event is ChangeProductCount) {
      int index = currentOrder.indexWhere((p) => p.id == event.id);
      currentOrder[index] = currentOrder[index].copyWith(qty: event.qty);
    }

    currentOrder = currentOrder.toSet().toList();
    pendingOrder = pendingOrder.toSet().toList();

    yield CartState(currentOrder, pendingOrder);
  }
}
