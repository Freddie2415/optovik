part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final id;

  const OrderSuccess(this.id);
}

class OrderFailure extends OrderState {
  final String message;

  OrderFailure({@required this.message});
}
