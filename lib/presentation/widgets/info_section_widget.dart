import 'package:flutter/material.dart';
import 'package:optovik/generated/l10n.dart';

import 'info_tile_widget.dart';

class InfoSection extends StatefulWidget {
  final List<InfoItem> list;

  const InfoSection({Key key, @required this.list}) : super(key: key);

  @override
  _InfoSectionState createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  List<InfoItem> list;
  bool readMore = false;

  @override
  void initState() {
    readMore = widget.list.length < 4;
    list = widget.list;
    super.initState();
  }

  List<InfoItem> get infoList => readMore ? list : list.sublist(0, 3);

  @override
  Widget build(BuildContext context) {
    if (infoList.isEmpty) {
      return SizedBox(height: 0, width: 0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).info,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        !readMore
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    readMore = true;
                  });
                },
                child: Text(
                  " ${S.of(context).more}",
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.end,
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
        ...infoList
            .map((e) => InfoTileWidget(
                  onTap: e.onTap,
                  value: e.value,
                  option: e.option,
                ))
            .toList()
      ],
    );
  }
}

class InfoItem {
  final String option;
  final String value;
  final Function onTap;

  const InfoItem({
    @required this.option,
    @required this.value,
    @required this.onTap,
  });
}
