import 'package:flutter/material.dart';
import 'package:optovik/domain/model/category.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/pages/categories.dart';

import 'collection_widget.dart';

class CategorySectionWidget extends StatelessWidget {
  final String title;
  final List<Category> categories;

  const CategorySectionWidget({
    Key key,
    @required this.title,
    @required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories == null || categories.isEmpty) {
      return Container(width: 0, height: 0);
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            title: Text(
              title.toUpperCase(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              S.of(context).showMore.toUpperCase(),
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                CategoriesPage.route(),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView.builder(
              itemBuilder: (
                context,
                index,
              ) {
                final category = categories[index];
                return CollectionWidget(
                  categoryId: category.id.toString(),
                  name: category.name,
                  image: category.icon,
                );
              },
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
