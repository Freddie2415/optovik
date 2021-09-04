import 'package:flutter/material.dart';

class FilterItemsPage extends StatefulWidget {
  final title;

  const FilterItemsPage({Key key, this.title}) : super(key: key);

  @override
  _FilterItemsPageState createState() => _FilterItemsPageState();
}

class _FilterItemsPageState extends State<FilterItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "готово",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "США",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.check_box_outline_blank),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "РОССИЯ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(Icons.check_box_outline_blank),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "УЗБЕКИСТАН",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(Icons.check_box_outline_blank),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "КАЗАХСТАН",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.check_box,
              color: Colors.indigo,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "УКРАИНА",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.check_box_outline_blank),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
