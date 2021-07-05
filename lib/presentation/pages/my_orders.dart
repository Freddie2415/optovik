import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/order.dart';
import 'package:optovik/presentation/widgets/order_item_widget.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Мои заказы")),
      // backgroundColor: Colors.,
      body: ListView(
        children: [
          OrderItem(
            id: 1234,
            date: "3 июня 2021 г. 19:24",
            status: "Заказ создан",
            address: "Город Самарканд ул Лахутий дом 38 а",
            client: "Фаррух Хамракулов",
            statusColor: Colors.amber,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(),
                ),
              );
            },
          ),
          OrderItem(
            id: 1234,
            date: "3 июня 2021 г. 19:24",
            status: "Оформлено",
            address: "Город Самарканд ул Лахутий дом 38 а",
            client: "Фаррух Хамракулов",
            statusColor: Colors.lightGreen,
            onTap: () {},
          ),
          OrderItem(
            id: 1234,
            date: "3 июня 2021 г. 19:24",
            status: "Доставлено",
            address: "Город Самарканд ул Лахутий дом 38 а",
            client: "Фаррух Хамракулов",
            statusColor: Colors.green,
            onTap: () {},
          ),
          OrderItem(
            id: 1234,
            date: "3 июня 2021 г. 19:24",
            status: "Отменено",
            address: "Город Самарканд ул Лахутий дом 38 а",
            client: "Фаррух Хамракулов",
            statusColor: Colors.redAccent,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
