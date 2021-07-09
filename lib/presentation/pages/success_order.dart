import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/home.dart';

class SuccessOrder extends StatelessWidget {
  final id;

  const SuccessOrder(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.lightGreen,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Спасибо за заказ!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Ожидайте, в скорем времени наш менеджер свяжется с вами.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Номер вашего заказа: ${id.toString()}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(elevation: 0),
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, HomePage.route());
                },
                label: Text(
                  "Вернуться на главную",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
