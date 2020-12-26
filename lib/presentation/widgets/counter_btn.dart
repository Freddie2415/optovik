import 'package:flutter/material.dart';

class CounterBtn extends StatelessWidget {
  final double height;
  final int counter;
  final Function onAdd;
  final Function onRemove;

  CounterBtn({
    Key key,
    this.height = 35,
    this.onAdd,
    this.onRemove,
    this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Material(
                child: IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  onPressed: onRemove,
                  padding: EdgeInsets.zero,
                ),
                color: Colors.lightGreen,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextButton(
                onPressed: () {},
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "$counter",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: " шт",
                      style: TextStyle(color: Colors.black87, fontSize: 11),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Material(
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: onAdd,
                  padding: EdgeInsets.zero,
                ),
                color: Colors.lightGreen,
                borderRadius:
                BorderRadius.horizontal(right: Radius.circular(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}