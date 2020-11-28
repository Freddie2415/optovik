import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/products.dart';

import 'product_widget.dart';

class ProductSectionWidget extends StatelessWidget {
  final String title;

  const ProductSectionWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            title: Text(
              title.toUpperCase(),
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              "Еще".toUpperCase(),
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsPage(title: title,),));
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height*.40,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ProductWidget(
                      id: "1",
                      name: "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image: "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "Вкусная цена",
                      promoColor: Colors.lightGreen,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image: "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "Вкусная цена",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image: "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      promo: " 3 по цене 1",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image: "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "Вкусная цена",
                      promoColor: Colors.lightGreen,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image: "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "Вкусная цена",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image: "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      promo: " 3 по цене 1",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image: "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "Вкусная цена",
                      promoColor: Colors.lightGreen,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image: "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "Вкусная цена",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image: "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      promo: " 3 по цене 1",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
