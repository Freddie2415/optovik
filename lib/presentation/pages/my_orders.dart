import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/order_list/order_list_cubit.dart';
import 'package:optovik/domain/model/order.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/pages/order.dart';
import 'package:optovik/presentation/widgets/error_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';
import 'package:optovik/presentation/widgets/message_widget.dart';
import 'package:optovik/presentation/widgets/order_item_widget.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.myOrders)),
      body: BlocBuilder<OrderListCubit, OrderListState>(
        cubit: BlocProvider.of<OrderListCubit>(context)..load(),
        builder: (context, state) {
          if (state is OrderListFailure) {
            return FailureWidget(
              message: state.message,
              onBtnPressed: () {},
            );
          }

          if (state is OrderListSuccess) {
            if (state.orderList.isEmpty) {
              return MessageWidget(
                message: S.current.emptyOrders,
                title: S.current.orders,
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                Order order = state.orderList[index];

                return OrderItem(
                  id: order.id,
                  date: order.created,
                  client: order.contact,
                  status: order.statusTitle,
                  address: order.address,
                  statusColor: order.statusColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(order),
                      ),
                    );
                  },
                );
              },
              itemCount: state.orderList.length,
            );
          }

          return LoadingWidget();
        },
      ),
    );
  }
}

enum OrderStatus {
  created,
  available,
  framed,
  sent,
  delivered,
}
