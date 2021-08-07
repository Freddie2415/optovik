import 'package:flutter/material.dart';

import 'my_separator.dart';

class InfoTileWidget extends StatelessWidget {
  final String option;
  final String value;
  final Function onTap;
  final TextStyle textStyle = TextStyle();

  InfoTileWidget({
    Key key,
    this.option,
    this.value,
    this.onTap,
  })  : assert(option != null),
        assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$option:",
                style: textStyle,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "$value",
                  style: textStyle,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DashSeparator(
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
