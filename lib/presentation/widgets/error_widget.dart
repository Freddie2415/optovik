import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String message;
  final Function onBtnPressed;

  const FailureWidget({Key key, this.message, this.onBtnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(20),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$message",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Divider(),
              ElevatedButton(
                onPressed: this.onBtnPressed,
                child: Text(
                  "ПОВТОРИТЬ",
                  style: TextStyle(
                    color: Colors.grey,
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
