import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optovik/data/api/service/auth_service.dart';
import 'package:optovik/data/api/service/order_service.dart';
import 'package:optovik/domain/bloc/order_form/order_form_cubit.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderService orderService;
  final AuthService authService;

  OrderCubit({
    @required this.orderService,
    @required this.authService,
  }) : super(OrderInitial());

  Future<void> sendOrder(OrderFormState form) async {
    emit(OrderLoading());

    try {
      final String token = await authService.getToken();
      var orderId = await orderService.create(token, form);

      emit(OrderSuccess(orderId));
    } catch (e) {
      print(e);
      emit(OrderFailure(message: e.toString()));
    }
  }
}
