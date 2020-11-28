import 'package:flutter/material.dart';

class FeedBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Обратная связь"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Text(
                "Время работы операторов с 9:00 до 21:00. В другое время Вы можете оставить голосовое сообщение."),
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.lightGreen,
            ),
            title: Text(
              "+998 93 353 24 15",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.lightGreen,
            ),
            title: Text(
              "Письмо в тех. поддержку",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
