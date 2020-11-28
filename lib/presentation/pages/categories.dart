import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/products.dart';
import 'package:optovik/presentation/pages/search.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  Category showAll = null;
  List<Category> list = [
    Category(
      id: 1,
      title: "Новый год 2021",
      children: [
        Category(id: 8, title: "Банкетное меню"),
        Category(id: 9, title: "Новогоднее настроение"),
        Category(id: 10, title: "Подарки на новый год"),
        Category(id: 11, title: "Накрываем на стол"),
      ],
      isMain: true,
    ),
    Category(
      id: 2,
      title: "Идеи для подарков",
      children: [
        Category(id: 12, title: "Подарочные корзины и наборы"),
        Category(id: 13, title: "Подарки для детей"),
        Category(id: 14, title: "Букеты и цветочные композиции"),
        Category(id: 15, title: "Подарочные карты"),
      ],
      isMain: true,
    ),
    Category(
      id: 3,
      title: "Средства защиты",
      children: [
        Category(id: 16, title: "Маски защитные, перчатки"),
        Category(id: 17, title: "Антисептики и гели"),
        Category(id: 18, title: "Мыло для рук"),
        Category(id: 19, title: "Дезинфицирующие средства"),
      ],
      isMain: true,
    ),
    Category(
      id: 4,
      title: "Фермерские продукты",
      children: [
        Category(id: 20, title: "Молоко. Сыры. Яйцо"),
        Category(id: 21, title: "Овощи, фрукты"),
        Category(id: 22, title: "Мясо, птица,рыба"),
        Category(id: 23, title: "Кондитерские изделия"),
      ],
      isMain: true,
    ),
    Category(
      id: 5,
      title: "Овощи, Фрукты",
      children: [
        Category(id: 24, title: "Банкетное меню"),
        Category(id: 25, title: "Новогоднее настроение"),
        Category(id: 26, title: "Подарки на новый год"),
        Category(id: 27, title: "Накрываем на стол"),
      ],
      isMain: true,
    ),
  ];

  List<Category> items = [];

  @override
  void initState() {
    super.initState();
    items = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Каталог товаров"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (showAll == null) {
              Navigator.pop(context);
            } else {
              setState(() {
                items = list;
                showAll = null;
              });
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(List.generate(10, (index) => "Text $index")),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          bool parent = showAll != null && showAll == item;
          return ListTile(
            title: Text(
              "${item.title}",
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    (parent || item.isMain) ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            onTap: () {
              if (item.children.isEmpty || parent) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductsPage(
                    title: "${item.title}",
                  ),
                ));
              } else {
                setState(() {
                  showAll = item;
                  item.children.remove(showAll);
                  item.children.insert(0, showAll);
                  items = item.children;
                });
              }
            },
            trailing: parent
                ? Text(
                    "Показать все",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  )
                : null,
            dense: true,
          );
        },
      ),
    );
  }
}

class Category {
  final id;
  final String title;
  final bool isMain;
  final List<Category> children;

  const Category(
      {this.id, this.title, this.children = const [], this.isMain = false});
}
