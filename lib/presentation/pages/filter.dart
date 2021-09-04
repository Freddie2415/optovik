import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/filter_items.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Фильтр"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "ОЧИСТИТЬ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Страна",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterItemsPage(title: "Страна"),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              "Цвет",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Вид",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Упаковка",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Основа",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          primary: Colors.indigo,
          splashFactory: NoSplash.splashFactory,
          minimumSize: Size.fromHeight(50),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "ПРИМЕНИТЬ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
