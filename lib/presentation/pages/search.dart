import 'package:flutter/material.dart';
import 'package:optovik/presentation/widgets/my_separator.dart';

class Search extends SearchDelegate {
  String selectedResult;
  final List<String> listExample;
  List<String> recentList = ["Text 4", "Text 3"];

  Search(this.listExample);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    if (query.isEmpty && recentList.isNotEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Недавние запросы",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Очистить",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
              ],
            ),
            MySeparator(color: Colors.grey),
            ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Мыло",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              dense: true,
            ),
            MySeparator(
              color: Colors.grey,
            ),
          ],
        ),
      );
    }

    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(
            listExample.where((element) => element.contains(query)),
          );

    return ListView.separated(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          dense: true,
          title: Text(
            suggestionList[index],
            style: TextStyle(fontSize: 14),
          ),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
      separatorBuilder: (context, index) {
        return MySeparator(color: Colors.grey);
      },
    );
  }
}
