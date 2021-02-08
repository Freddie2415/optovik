import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';

class CartModule {
  static CartBloc _cartBloc;

  static CartBloc cartBloc() {
    if (_cartBloc == null) {
      _cartBloc = CartBloc(RepositoryModule.cartRepository());
      _cartBloc.add(CartInit());
    }
    return _cartBloc;
  }
}
