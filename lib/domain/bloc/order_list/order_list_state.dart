part of 'order_list_cubit.dart';

abstract class OrderListState extends Equatable {
  const OrderListState();

  @override
  List<Object> get props => [];
}

class OrderListInitial extends OrderListState {}

class OrderListLoading extends OrderListState {}

class OrderListSuccess extends OrderListState {
  final List<Order> orderList;

  OrderListSuccess({this.orderList});
}

class OrderListFailure extends OrderListState {
  final String message;

  OrderListFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
