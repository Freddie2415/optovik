import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optovik/domain/model/sort_type.dart';

class SortPopupButton extends StatefulWidget {
  final Function(SortType sortType) onSelect;

  const SortPopupButton({Key key, this.onSelect}) : super(key: key);

  @override
  _SortPopupButtonState createState() => _SortPopupButtonState(onSelect);
}

class _SortPopupButtonState extends State<SortPopupButton> {
  SortType sortValue = SortType.default_sort;
  final Function(SortType sortType) onSelect;

  _SortPopupButtonState(this.onSelect);

  @override
  Widget build(BuildContext context) {
/*    if (Platform.isAndroid)
      return PopupMenuButton(
        tooltip: "Сортировка",
        onSelected: onSelected,
        itemBuilder: (context) {
          final List<PopupMenuEntry> sort = [
            PopupMenuItem<SortType>(
              value: SortType.default_sort,
              child: ListTile(
                title: Text("По умолчанию"),
                dense: true,
                trailing: _trailing(SortType.default_sort),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0),
              ),
            ),
            PopupMenuItem<SortType>(
              value: SortType.name_asc,
              child: ListTile(
                title: Text("По алвавиту"),
                dense: true,
                trailing: _trailing(SortType.name_asc),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0),
              ),
            ),
            PopupMenuItem<SortType>(
              value: SortType.name_desc,

              child: ListTile(
                title: Text("Сначала недогорие"),
                dense: true,
                trailing: _trailing(SortType.name_desc),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0),
              ),
            ),
            PopupMenuItem<SortType>(
              value: SortType.price_desc,
              child: ListTile(
                title: Text("Сначала дорогие"),
                dense: true,
                trailing: _trailing(SortType.price_desc),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0),
              ),
            ),
            PopupMenuItem<SortType>(
              value: SortType.price_asc,
              child: ListTile(
                title: Text("По новизне"),
                dense: true,
                trailing: _trailing(SortType.price_asc),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0),
              ),
            ),
          ];
          return sort;
        },
        // icon: Icon(Icons.sort),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "По популярности",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.sort,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
        offset: Offset(500.0, 100.0),
      );*/

    return PopupMenuButton(
      tooltip: "Сортировка",
      onSelected: onSelected,
      itemBuilder: (context) {
        final List<PopupMenuEntry> sort = [
          PopupMenuItem<SortType>(
            value: SortType.default_sort,
            child: ListTile(
              title: Text("По умолчанию"),
              dense: true,
              trailing: _trailing(SortType.default_sort),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
          ),
          PopupMenuItem<SortType>(
            value: SortType.name_asc,
            child: ListTile(
              title: Text("По алвавиту"),
              dense: true,
              trailing: _trailing(SortType.name_asc),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
          ),
          PopupMenuItem<SortType>(
            value: SortType.name_desc,

            child: ListTile(
              title: Text("Сначала недогорие"),
              dense: true,
              trailing: _trailing(SortType.name_desc),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
          ),
          PopupMenuItem<SortType>(
            value: SortType.price_desc,
            child: ListTile(
              title: Text("Сначала дорогие"),
              dense: true,
              trailing: _trailing(SortType.price_desc),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
          ),
          PopupMenuItem<SortType>(
            value: SortType.price_asc,
            child: ListTile(
              title: Text("По новизне"),
              dense: true,
              trailing: _trailing(SortType.price_asc),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
          ),
        ];
        return sort;
      },
      // icon: Icon(Icons.sort),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "По популярности",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.sort,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
      offset: Offset(500.0, 100.0),
    );

    /*return FlatButton(
      child: Icon(Icons.sort),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => _cupertinoActionSheet(),
        );
      },
    );*/
  }

  Widget _trailing(SortType sortType) {
    return sortValue == sortType
        ? Icon(
            Icons.radio_button_checked,
            color: Colors.lightGreen,
          )
        : Icon(Icons.radio_button_unchecked);
  }

  _textStyleBySort(SortType sortType) {
    return TextStyle(
        color: sortType == sortValue ? Colors.black : Colors.black54);
  }

  Widget _cupertinoActionSheet() {
    return CupertinoActionSheet(
      title: Text('Сортировать список товаров'),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Отмена",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            onSelected(SortType.default_sort);
            Navigator.pop(context);
          },
          child: Text(
            "По умолчанию",
            style: _textStyleBySort(SortType.default_sort),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            onSelected(SortType.name_asc);
            Navigator.pop(context);
          },
          child: Text(
            "По алфавиту",
            style: _textStyleBySort(SortType.name_asc),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            onSelected(SortType.name_desc);
            Navigator.pop(context);
          },
          child: Text(
            "Сначала недорогие",
            style: _textStyleBySort(SortType.name_desc),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            onSelected(SortType.price_asc);
            Navigator.pop(context);
          },
          child: Container(
            child: Text(
              "Сначала дорогие",
              style: _textStyleBySort(SortType.price_asc),
            ),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            onSelected(SortType.price_desc);
            Navigator.pop(context);
          },
          child: Text(
            "По новизне",
            style: _textStyleBySort(SortType.price_desc),
          ),
        )
      ],
    );
  }

  void onSelected(value) {
    setState(() {
      sortValue = value;
    });
    onSelect(sortValue);
  }
}
