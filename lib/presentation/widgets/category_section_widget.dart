
import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/collections.dart';

import 'collection_widget.dart';

class CategorySectionWidget extends StatelessWidget {
  final String title;

  const CategorySectionWidget({Key key, this.title}) : super(key: key);

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
                fontSize: 14, fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CollectionsPage(),
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                CollectionWidget(
                  name: "Фрукты",
                  image:
                  "https://images.chesscomfiles.com/uploads/v1/user/12536806.eecbe5da.1200x1200o.9620a10cf7b1.jpeg",
                ),
                CollectionWidget(
                  name: "Овощи",
                  image:
                  "https://vitamina.net.pl/wp-content/uploads/2016/07/blog-warzywa-i-owoce2.jpg",
                ),
                CollectionWidget(
                  name: "Сухофрукты",
                  image:
                  "https://wallbox.ru/resize/1024x1024/wallpapers/main2/201715/orehi-eda-mindal-inzir-kuraga-suhofrukty-finiki.jpg",
                ),
                CollectionWidget(
                  name: "Молочные изделия",
                  image:
                  "https://megaport.hu/media/king-include/uploads/2019/01/thumb_tej-turo-sajt-8939744296.jpg",
                ),
                CollectionWidget(
                  name: "Колбасные изделия",
                  image:
                  "https://cache3.youla.io/files/images/780_780/5b/0d/5b0d743d2aecd626da1651b2.jpg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}