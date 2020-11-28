import 'package:flutter/material.dart';
import 'package:optovik/presentation/widgets/product_widget.dart';

class CollectionDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Детали коллекции"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Text(
                  "Выгодные правила игры ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн. Его популяризации в новое время послужили публикация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время, программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.'),
                Divider(),
              ])),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  childAspectRatio: 80 / 100,
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
    );
  }
}
