import 'package:flutter/material.dart';

class FaultWidget extends StatelessWidget {
  final message;

  const FaultWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Text(
            "$message",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
