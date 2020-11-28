import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/filter.dart';
import 'package:optovik/presentation/pages/search.dart';
import 'package:optovik/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:optovik/presentation/widgets/product_widget.dart';
import 'package:optovik/presentation/widgets/sort_button_widget.dart';

class ProductsPage extends StatelessWidget {
  final String title;

  const ProductsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(List.generate(10, (index) => "Text $index")),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => FilterPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Фильтры",
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SortPopupButton(
                    onSelect: (sortType) {},
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(45.0),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 8,
          ),
          child: CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  childAspectRatio: 80/100,
                ),
                delegate: SliverChildListDelegate(
                  [
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image:
                          "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "-50% ",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image:
                          "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image:
                          "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "-50% ",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image:
                          "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image:
                          "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "-50% ",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image:
                          "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image:
                          "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "-50% ",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image:
                          "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                      image:
                          "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "new",
                      promoColor: Colors.green,
                    ),
                    ProductWidget(
                      id: "1",
                      name:
                          "Сливки питьевые натуральные ультрапастеризованные 34%",
                      image:
                          "https://business.savetime.net/img/landing/categories/milk@2x.jpg",
                      price: "5 999",
                      oldPrice: "8 000",
                      unit: "1 шт (500г)",
                      promo: "-50% ",
                      promoColor: Colors.red,
                    ),
                    ProductWidget(
                      id: "1",
                      name: "Банан",
                      image:
                          "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                      price: "25 000",
                      // oldPrice: "8 000",
                      unit: "1 шт (1 кг)",
                      // promo: "-50% ",
                      // promoColor: Colors.red,
                    ),
                  ],
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ]))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
