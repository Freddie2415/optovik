
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
  String currentSortText = 'По популярности';
  _SortPopupButtonState(this.onSelect);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortType>(
      tooltip: "Сортировка",
      onSelected: onSelected,
      itemBuilder: (context) {
        final List<PopupMenuEntry<SortType>> sort = [
          PopupMenuItem<SortType>(
            value: SortType.default_sort,
            child: ListTile(
              title: Text("По популярности"),
              dense: true,
              trailing: _trailing(SortType.default_sort),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
          ),
          PopupMenuItem<SortType>(
            value: SortType.name_asc,
            child: ListTile(
              title: Text("По алфавиту (A-Я)"),
              dense: true,
              trailing: _trailing(SortType.name_asc),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
          ),
          PopupMenuItem<SortType>(
            value: SortType.name_desc,

            child: ListTile(
              title: Text("По алфавиту (Я-А)"),
              dense: true,
              trailing: _trailing(SortType.name_desc),
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
            "$currentSortText",
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

/*  _textStyleBySort(SortType sortType) {
    return TextStyle(
        color: sortType == sortValue ? Colors.black : Colors.black54);
  }*/

  /*Widget _cupertinoActionSheet() {
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
      ],
    );
  }*/

  void onSelected(SortType value) {
    setState(() {
      sortValue = value;
      switch(value){
        case SortType.default_sort:
          currentSortText = 'По популярности';
          break;
        case SortType.name_asc:
          currentSortText = 'По алфавиту (A-Я)';
          break;
        case SortType.name_desc:
          currentSortText = 'По алфавиту (Я-А)';
          break;
      }
    });
    onSelect(sortValue);
  }
}
