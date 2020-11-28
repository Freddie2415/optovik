import 'package:flutter/material.dart';
import 'package:optovik/presentation/widgets/product_section_widget.dart';

class Cart extends StatelessWidget {
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
                text: "ТУКУЩИЙ ЗАКАЗ (3)",
              ),
              Tab(
                text: "ОТЛОЖЕННЫЕ (3)",
              ),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, bottom: 5),
                  child: Text(
                    "ТОВАРЫ В КОРЗИНЕ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductSectionWidget(
                  title: "Рекомендованные товары",
                ),
                TextButton(
                  onPressed: () {},
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
                    onPressed: () {},
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
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title:
                      "Сахарный песок тростниковый белый Pininpero 1 кг, Италия",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://img.dalimo.ru/1000/products/W2533-0e118021a8cb3a00e39963acdade388c.jpg",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                ProductCartWidget(
                  title: "Банан",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://im0-tub-com.yandex.net/i?id=15cdf3c04392d3d8b7c6c76f9f3e0e89&n=13&exp=1",
                ),
                ProductCartWidget(
                  title: "Яблоки",
                  count: "1 шт",
                  price: "5 999 сум",
                  image:
                      "https://ceradis.com/wp-content/uploads/2017/09/apples-1024x1024.jpg",
                ),
                TextButton(
                  onPressed: () {},
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
                  onPressed: () {},
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
          ),
        ]),
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

class ProductCartWidget extends StatelessWidget {
  final image;
  final title;
  final price;
  final count;

  const ProductCartWidget(
      {Key key, this.image, this.title, this.price, this.count})
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
                          maxLines: 3,
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
                              "$count",
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
                  onSelected: (value) {},
                  itemBuilder: (context) {
                    final List<PopupMenuEntry> sort = [
                      PopupMenuItem<String>(
                        value: "A",
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
                      PopupMenuItem<String>(
                        value: "B",
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
                      PopupMenuItem<String>(
                        value: "C",
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
                    return sort;
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
}
