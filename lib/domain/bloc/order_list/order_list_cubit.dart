import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optovik/data/api/service/auth_service.dart';
import 'package:optovik/data/api/service/order_service.dart';
import 'package:optovik/domain/model/order.dart';

part 'order_list_state.dart';

class OrderListCubit extends Cubit<OrderListState> {
  final OrderService orderService;
  final AuthService authService;

  OrderListCubit(this.orderService, this.authService)
      : super(OrderListInitial());

  load() async {
    emit(OrderListLoading());

    try {
      String token = await authService.getToken();
      final orderList = await orderService.getAll(token);
      emit(OrderListSuccess(orderList: orderList));
    } catch (e) {
      print(e);
      emit(OrderListFailure(message: e.toString()));
    }
  }
}
