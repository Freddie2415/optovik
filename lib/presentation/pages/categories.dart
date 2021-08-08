import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/categories/categories_bloc.dart';
import 'package:optovik/domain/bloc/tree/tree_cubit.dart';
import 'package:optovik/domain/model/category.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/pages/products.dart';
import 'package:optovik/presentation/pages/search.dart';
import 'package:optovik/presentation/widgets/error_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';

class CategoriesPage extends StatelessWidget {
  final CategoriesBloc categoriesBloc;
  final TreeCubit treeCubit = TreeCubit();

  CategoriesPage({Key key, this.categoriesBloc}) : super(key: key);

  static Route<MaterialPageRoute> route(CategoriesBloc categoriesBloc) {
    return MaterialPageRoute(
      builder: (context) => CategoriesPage(categoriesBloc: categoriesBloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).productCatalog),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => onPressBack(context),
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
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      cubit: categoriesBloc,
      builder: (context, state) {
        if (state is CategoriesReady) {
          treeCubit.setCategories(state.categories);
          return RefreshIndicator(
            child: CategoriesTreeList(treeCubit),
            onRefresh: () {
              treeCubit.resetData();
              categoriesBloc.add(RefreshCategories());
              return categoriesBloc.firstWhere((e) => e is! RefreshCategories);
            },
          );
        }

        if (state is CategoriesLoading) {
          return LoadingWidget();
        }

        if (state is CategoriesError) {
          return FailureWidget(
            message: state.message,
            onBtnPressed: _tryReload,
          );
        }

        return Container();
      },
    );
  }

  void onPressBack(context) {
    treeCubit.back(() {
      Navigator.pop(context);
    });
  }

  void _tryReload() {
    this.categoriesBloc.add(LoadCategories());
  }
}

class CategoriesTreeList extends StatelessWidget {
  final TreeCubit treeCubit;

  const CategoriesTreeList(this.treeCubit, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreeCubit, List<Category>>(
      cubit: treeCubit,
      builder: (context, items) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          bool parent = treeCubit.isParent(item);
          return ListTile(
            leading: (treeCubit.selectedCategory == null || parent)
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
              treeCubit.selectItem(
                item,
                () => navigateToCategory(context, item),
              );
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

  void navigateToCategory(BuildContext context, Category item) {
    Navigator.of(context).push(
      ProductsPage.route(
          title: "${item.name}",
          categoryId: item.id,
          query: null,
          isSearchPage: false),
    );
  }
}
