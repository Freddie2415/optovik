import 'package:flutter/material.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/counter_module.dart';
import 'package:optovik/presentation/pages/products.dart';

import 'product_widget.dart';

class ProductSectionWidget extends StatelessWidget {
  final String title;
  final List<Product> products;
  final categoryId;

  const ProductSectionWidget(
      {Key key, @required this.title, @required this.products, this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products == null || products.isEmpty) {
      return Container(width: 0, height: 0);
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            title: Text(
              title.toUpperCase(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              S.current.more.toUpperCase(),
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  ProductsPage.route(
                    title: title,
                    categoryId: categoryId,
                  ));
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * .40,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: products
                      .map((product) => ProductWidget(
                            product,
                            CounterModule.counterCubit(product),
                            id: product.id.toString(),
                            name: "${product.title}",
                            image: "${product.image}",
                            price: "",
                            oldPrice: "",
                            unit: "${product.unit}",
                            promo: "${product.promo}",
                            promoColor: Colors.lightGreen,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
