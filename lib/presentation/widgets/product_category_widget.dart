import 'package:flutter/material.dart';

class ProductCategoryWidget extends StatelessWidget {
  final String title;
  final id;
  final Function onTap;

  const ProductCategoryWidget({
    Key key,
    this.title,
    this.onTap,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return Container(height: 0, width: 0);
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.widgets_outlined,
              color: Colors.indigo,
            ),
            SizedBox(width: 10),
            Text(
              "$title",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            ),
            Spacer(),
            Text(
              "ID - $id",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
