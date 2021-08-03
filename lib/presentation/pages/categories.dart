import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/categories/categories_bloc.dart';
import 'package:optovik/domain/model/category.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/categories_module.dart';
import 'package:optovik/presentation/pages/products.dart';
import 'package:optovik/presentation/pages/search.dart';
import 'package:optovik/presentation/widgets/error_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';

class CategoriesPage extends StatefulWidget {
  final List<Category> categories;

  const CategoriesPage({Key key, this.categories}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();

  static Route<MaterialPageRoute> route() {
    return MaterialPageRoute(
      builder: (context) => BlocBuilder(
        cubit: CategoriesModule.categoriesBloc(),
        builder: _builder,
      ),
    );
  }

  static Widget _builder(BuildContext context, state) {
    if (state is CategoriesLoading || state is CategoriesInitial) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).productCatalog),
        ),
        body: LoadingWidget(),
      );
    }

    if (state is CategoriesError) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).productCatalog),
        ),
        body: FailureWidget(
            message: state.message,
            onBtnPressed: () {
              CategoriesModule.categoriesBloc().add(LoadCategories());
            }),
      );
    }

    final categories = (state as CategoriesReady).categories ?? [];

    return CategoriesPage(categories: categories);
  }
}

class _CategoriesPageState extends State<CategoriesPage> {
  Category selectedCategory;
  List<Category> items = [];
  List<Category> tree = [];

  @override
  void initState() {
    super.initState();
    items = widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).productCatalog),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: onPressBack,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          bool parent = selectedCategory != null && selectedCategory == item;
          return ListTile(
            leading: (selectedCategory == null || parent)
                ? Image.network(
              item.icon,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.widgets_outlined);
              },
              height: 50,
              width: 50,
            )
                : Icon(Icons.keyboard_arrow_right),
            title: Text("${item.name}"),
            onTap: () {
              if (item.children.isEmpty || parent) {
                Navigator.of(context).push(ProductsPage.route(
                    title: "${item.name}",
                    categoryId: item.id,
                    query: null,
                    isSearchPage: false));
              } else {
                setState(() {
                  selectedCategory = item;
                  item.children.remove(selectedCategory);
                  item.children.insert(0, selectedCategory);
                  items = item.children;
                  tree.add(item);
                  tree = tree.toSet().toList();
                });
              }
            },
            trailing: parent
                ? Text(
              S.of(context).showAll,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            )
                : null,
            dense: true,
          );
        },
      ),
    );
  }

  void onPressBack() {
    if (tree.isEmpty) {
      Navigator.pop(context);
    } else {
      setState(() {
        tree.removeLast();

        if (tree.isEmpty) {
          selectedCategory = null;
          items = widget.categories;
          return;
        }

        Category category = tree.last;
        category.children.remove(category);
        category.children.insert(0, category);
        selectedCategory = category;
        items = selectedCategory.children;
      });
    }
  }
}
