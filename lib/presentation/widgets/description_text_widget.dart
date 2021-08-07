import 'package:flutter/material.dart';
import 'package:optovik/generated/l10n.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget(this.text, {Key key}) : super(key: key);

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  int maxLines = 3;

  @override
  Widget build(BuildContext context) {
    if (widget.text == null || widget.text.isEmpty) {
      return Container(width: 0.0, height: 0.0);
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            textAlign: TextAlign.justify,
            maxLines: maxLines,
          ),
          SizedBox(
            height: 5,
          ),
          maxLines <= 3
              ? GestureDetector(
            onTap: () {
              setState(() {
                maxLines = 1000;
              });
            },
            child: Text(
              " ${S.of(context).more}",
              style: TextStyle(color: Colors.green),
            ),
          )
              : Container(
            height: 0,
            width: 0,
          ),
        ],
      ),
    );
  }
}