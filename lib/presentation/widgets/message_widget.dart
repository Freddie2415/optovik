import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String title;
  final String message;

  const MessageWidget({Key key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title != null && message != null) {
      return Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "$message",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      );
    }
    if (title == null && message != null) {
      return Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              "$message",
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    if (message == null && title != null) {
      return Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              "$title",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox();
  }
}