import 'package:optovik/domain/bloc/counter/counter_cubit.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/internal/dependencies/cart_module.dart';

class CounterModule {
  static CounterCubit counterCubit(Product product) => CounterCubit(product,CartModule.cartBloc());
}
