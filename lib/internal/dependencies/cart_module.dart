import 'package:optovik/domain/bloc/cart/cart_bloc.dart';

class CartModule {
  static CartBloc _cartBloc;

  static CartBloc cartBloc() {
    if (_cartBloc == null) {
      _cartBloc = CartBloc();
    }
    return _cartBloc;
  }
}
