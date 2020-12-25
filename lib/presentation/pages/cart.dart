import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'dart:core';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/internal/dependencies/cart_module.dart';
import 'package:optovik/presentation/widgets/product_section_widget.dart';

class Cart extends StatelessWidget {
  final CartBloc _cartBloc = CartModule.cartBloc();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Корзина"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "ТЕКУЩИЙ ЗАКАЗ",
              ),
              Tab(
                text: "ОТЛОЖЕННЫЕ",
              ),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          cubit: _cartBloc,
          builder: (context, state) => TabBarView(children: [
            state.orders.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, bottom: 5),
                          child: Text(
                            "ТОВАРЫ В КОРЗИНЕ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...state.orders
                            .map(
                              (Product e) => ProductCartWidget(
                                id: e.id,
                                title: "${e.title}",
                                count: "${e.qty}",
                                price: "",
                                image: "${e.image}",
                                isOrder: true,
                              ),
                            )
                            .toList(),
                        ProductSectionWidget(
                          title: "Рекомендованные товары",
                          products: [],
                        ),
                        TextButton(
                          onPressed: () {
                            CartModule.cartBloc().add(PostponeAll());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.refresh),
                              SizedBox(width: 10),
                              Text(
                                "Перенести заказ в отложенные".toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              CartModule.cartBloc().add(ClearOrder());
                            },
                            child: Row(
                              children: [
                                Icon(Icons.clear),
                                SizedBox(width: 10),
                                Text(
                                  "Очистить корзину".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )
                : MessageWidget(
                    title: "Корзина пуста",
                    message: "Вы можете добавить товары в корзину из каталога.",
                  ),
            state.postponed.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...state.postponed.map(
                          (e) => ProductCartWidget(
                            id: e.id,
                            title: "${e.title}",
                            count: "${e.qty}",
                            price: "",
                            image: "${e.image}",
                            isOrder: false,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            CartModule.cartBloc().add(TransferToOrder());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart),
                              SizedBox(width: 10),
                              Text(
                                "Перенести товары в заказ".toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            CartModule.cartBloc().add(ClearPendingOrder());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.clear),
                              SizedBox(width: 10),
                              Text(
                                "Удалить список".toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : MessageWidget(
                    title: "Отложенных товаров нет",
                    message: "Пока вы не отложили ни одного товара",
                  ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.lightGreen,
          child: Container(
            height: 100,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.white,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Сумма заказа:",
                      ),
                      Text(
                        "25 000 сум",
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                FlatButton(
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {},
                  child: Text(
                    "ПРОДОЛЖИТЬ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String title;
  final String message;

  const MessageWidget({Key key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "$message",
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCartWidget extends StatelessWidget {
  final id;
  final image;
  final title;
  final price;
  final count;
  final bool isOrder;

  const ProductCartWidget(
      {Key key,
      this.id,
      this.image,
      this.title,
      this.price,
      this.count,
      this.isOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Flexible(
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/placeholder.jpg",
              image: "$image",
            ),
          ),
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$title",
                          style: TextStyle(fontSize: 13),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "$price",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "$count шт",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                ),
                PopupMenuButton(
                  tooltip: "Действия",
                  onSelected: (value) => _onSelected(value, context),
                  itemBuilder: (context) {
                    final List<PopupMenuEntry<CartEvent>>
                        currentOrderMenuItems = [
                      PopupMenuItem<CartEvent>(
                        value: PostponeProduct(id),
                        child: ListTile(
                          title: Text(
                            "Отложить",
                            style: TextStyle(fontSize: 13),
                          ),
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          trailing: Icon(Icons.refresh),
                        ),
                      ),
                      PopupMenuItem<CartEvent>(
                        value: RemoveFromCurrentOrder(id),
                        child: ListTile(
                          title: Text(
                            "Удалить",
                            style: TextStyle(fontSize: 13),
                          ),
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          trailing: Icon(Icons.delete_forever),
                        ),
                      ),
                      PopupMenuItem<CartEvent>(
                        value: ChangeProductCount(id),
                        child: ListTile(
                          title: Text(
                            "Изменить",
                            style: TextStyle(fontSize: 13),
                          ),
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                    ];
                    final List<PopupMenuEntry<CartEvent>>
                        postponedOrderMenuItems = [
                      PopupMenuItem<CartEvent>(
                        value: FromPostponeToCart(id),
                        child: ListTile(
                          title: Text(
                            "Добавить в корзину",
                            style: TextStyle(fontSize: 13),
                          ),
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          trailing: Icon(
                            Icons.add_shopping_cart_outlined,
                          ),
                        ),
                      ),
                      PopupMenuItem<CartEvent>(
                        value: RemoveFromPostponed(id),
                        child: ListTile(
                          title: Text(
                            "Удалить",
                            style: TextStyle(fontSize: 13),
                          ),
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          trailing: Icon(Icons.delete_forever),
                        ),
                      ),
                    ];

                    return isOrder
                        ? currentOrderMenuItems
                        : postponedOrderMenuItems;
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.lightGreen,
                  ),
                  offset: Offset(500.0, 100.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onSelected(CartEvent value, context) async {
    if (value is ChangeProductCount) {
      int count = await _show(context);
      print("COUNT: $count");
      CartModule.cartBloc().add(value.copyWith(qty: count));
    } else {
      CartModule.cartBloc().add(value);
    }
  }

  Future<int> _show(context) async {
    TextEditingController countController =
        TextEditingController(text: "$count");

    Widget dialog = CupertinoAlertDialog(
      title: Text(
        "Введите количество",
        style: TextStyle(
            fontSize: 16,
            // color: kSecondaryColor,
            fontWeight: FontWeight.bold),
      ),
      content: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: TextField(
          decoration: InputDecoration(
            prefixText: "Кол-во: ",
            prefixStyle: TextStyle(
                fontWeight: FontWeight.bold),
          ),
          maxLines: 1,
          maxLength: 7,
          autofocus: true,
          keyboardType: TextInputType.number,
          controller: countController,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text("ОТМЕНА"),
          // textStyle: TextStyle(color: kSecondaryColor),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK"),
          isDefaultAction: true,
        ),
      ],
    );

    if (Platform.isAndroid) {
      dialog = AlertDialog(
        titleTextStyle: TextStyle(
            fontSize: 16,
            // color: kSecondaryColor,
            fontWeight: FontWeight.bold),
        title: Text("Введите количество"),
        content: Container(
          child: TextField(
            decoration: InputDecoration(prefixText: "Кол-во: "),
            maxLines: 1,
            maxLength: 7,
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: countController,
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () => Navigator.pop(context), child: Text("ОТМЕНА")),
          FlatButton(
            onPressed: () {
              int count = int.tryParse(countController.text) ?? this.count;
              count = count.abs();
              Navigator.pop(context);
            },
            child: Text("ОК"),
          ),
        ],
      );
    }

    await showDialog(context: context, builder: (context) => dialog);

    return int.parse(
      countController.text,
      onError: (source) => 1,
    ).abs();
  }
}
