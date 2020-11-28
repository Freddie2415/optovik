import 'package:flutter/material.dart';

class CounterBtn extends StatefulWidget {
  final double height;
  final Function onAdd;
  final Function onRemove;
  final initialIterator;

  CounterBtn(
      {Key key,
        this.height = 35,
        this.onAdd,
        this.onRemove,
        this.initialIterator = 1})
      : super(key: key);

  @override
  _CounterBtnState createState() => _CounterBtnState();
}

class _CounterBtnState extends State<CounterBtn> {
  int iterator = 1;

  @override
  void initState() {
    super.initState();
    iterator = widget.initialIterator;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
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
                  onPressed: () {
                    setState(() {
                      iterator--;
                    });
                    if(iterator <= 0){
                      widget.onRemove();
                      iterator = 1;
                    }
                  },
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
                      text: "$iterator",
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
                  onPressed: () {
                    widget.onAdd();
                    setState(() {
                      iterator++;
                    });
                  },
                  padding: EdgeInsets.zero,
                ),
                color: Colors.lightGreen,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}