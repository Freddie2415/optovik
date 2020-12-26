import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'package:optovik/domain/model/product.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<int> {
  StreamSubscription subscription;
  final CartBloc _cartBloc;
  Product _product;

  CounterCubit(this._product, this._cartBloc) : super(_product.qty) {
    subscription = _cartBloc.listen((state) {
      if (state.orders.any((p) => p.id == this._product.id)) {
        final p = state.orders.firstWhere((p) => p.id == this._product.id);
        this.setValue(p.qty);
        print(state.orders);
      }else{
        setValue(0);
      }
    });
  }

  void setValue(int value) {
    _product = _product.copyWith(qty: value);
    emit(_product.qty);
  }

  void increment() {
    final qty = state + 1;

    _product = _product.copyWith(qty: qty);

    _cartBloc.add(ChangeProductCount(_product, qty));
    print("INCREMENT: $qty");

    emit(_product.qty);
  }

  void decrement() {
    final qty = state - 1;

    _product = _product.copyWith(qty: qty);

    _cartBloc.add(ChangeProductCount(_product, qty));
    print("DECREMENT: $qty");

    emit(_product.qty);

  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
