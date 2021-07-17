
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
      icon: Icon(Icons.sort_rounded),
    );
  }

  Widget _trailing(SortType sortType) {
    return sortValue == sortType
        ? Icon(
            Icons.radio_button_checked,
            color: Colors.lightGreen,
          )
        : Icon(Icons.radio_button_unchecked);
  }
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
