import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/categories/categories_bloc.dart';
import 'package:optovik/domain/model/category.dart';
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
          title: Text('Каталог товаров'),
        ),
        body: LoadingWidget(),
      );
    }

    if (state is CategoriesError) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Каталог товаров'),
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
  Category showAll;

  List<Category> items = [];

  @override
  void initState() {
    super.initState();
    items = widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Каталог товаров"),
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
          bool parent = showAll != null && showAll == item;
          return ListTile(
            leading: (showAll == null || parent)
                ? Image.network(item.icon)
                : Icon(Icons.keyboard_arrow_right),
            title: Text(
              "${item.name}",
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    (parent || item.isMain) ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            onTap: () {
              if (item.children.isEmpty || parent) {
                Navigator.of(context).push(ProductsPage.route(
                  title: "${item.name}",
                  categoryId: item.id,
                  query: null,
                  isSearchPage: false
                ));
              } else {
                setState(() {
                  showAll = item;
                  item.children.remove(showAll);
                  item.children.insert(0, showAll);
                  items = item.children;
                });
              }
            },
            trailing: parent
                ? Text(
                    "Показать все",
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
    if (showAll == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        items = widget.categories;
        showAll = null;
      });
    }
  }
}
