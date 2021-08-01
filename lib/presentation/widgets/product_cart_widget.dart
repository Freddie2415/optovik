import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/cart_module.dart';

class ProductCartWidget extends StatelessWidget {
  final id;
  final image;
  final title;
  final price;
  final count;
  final bool isOrder;
  final Product product;

  const ProductCartWidget({
    Key key,
    this.product,
    this.id,
    this.image,
    this.title,
    this.price,
    this.count,
    this.isOrder,
  }) : super(key: key);

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
                              "$count ${S.current.piece}",
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
                  tooltip: S.current.actions,
                  onSelected: (value) => _onSelected(value, context),
                  itemBuilder: (context) {
                    final List<PopupMenuEntry<CartEvent>>
                    currentOrderMenuItems = [
                      PopupMenuItem<CartEvent>(
                        value: PostponeProduct(product),
                        child: ListTile(
                          title: Text(
                            S.current.postpone,
                            style: TextStyle(fontSize: 13),
                          ),
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          trailing: Icon(Icons.refresh),
                        ),
                      ),
                      PopupMenuItem<CartEvent>(
                        value: RemoveFromCurrentOrder(product),
                        child: ListTile(
                          title: Text(
                            S.current.delete,
                            style: TextStyle(fontSize: 13),
                          ),
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          trailing: Icon(Icons.delete_forever),
                        ),
                      ),
                      PopupMenuItem<CartEvent>(
                        value: ChangeProductCount(product),
                        child: ListTile(
                          title: Text(
                            S.current.edit,
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
                        value: FromPostponeToCart(product),
                        child: ListTile(
                          title: Text(
                            S.current.addToCard,
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
                        value: RemoveFromPostponed(product),
                        child: ListTile(
                          title: Text(
                            S.current.delete,
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
        S.current.enterQuantity,
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
            prefixText: S.current.qty,
            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
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
          child: Text(S.current.cancel),
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
        title: Text(S.current.enterQuantity),
        content: Container(
          child: TextField(
            decoration: InputDecoration(prefixText: S.current.qty),
            maxLines: 1,
            maxLength: 7,
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: countController,
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () => Navigator.pop(context), child: Text(S.current.cancel)),
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