import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Информация"),
      ),
      body: Column(
        children: [
          Image.asset("assets/images/info-banner.jpg"),
          ListTile(
            title: Text("Оферта", style: TextStyle(fontSize: 14),),
            onTap: () {},
          ),
          ListTile(
            title: Text("Доставка", style: TextStyle(fontSize: 14),),
            onTap: () {},
          ),
          ListTile(
            title: Text("Политика защиты и персональных данных", style: TextStyle(fontSize: 14),),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
