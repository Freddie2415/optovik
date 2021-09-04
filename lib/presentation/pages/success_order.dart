import 'package:flutter/material.dart';
import 'package:optovik/generated/l10n.dart';
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
                color: Colors.indigo,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                S.of(context).thankYouForOrdering,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                S.of(context).wait,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "${S.of(context).orderId} ${id.toString()}",
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
                  S.of(context).goHome,
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
