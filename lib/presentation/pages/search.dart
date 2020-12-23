import 'package:flutter/material.dart';
import 'package:optovik/domain/bloc/search_sugesstions/search_suggestions_bloc.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/internal/dependencies/products_module.dart';
import 'package:optovik/presentation/pages/products.dart';
import 'package:optovik/presentation/widgets/search_suggestion_widget.dart';

class Search extends SearchDelegate<Product> {
  final SearchSuggestionsBloc _searchSuggestionsBloc =
      ProductsModule.searchSuggestionBloc();

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
    return ProductsPage.search(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchSuggestionsWidget(_searchSuggestionsBloc);
  }

  @override
  void close(BuildContext context, Product result) {
    super.close(context, result);
    _searchSuggestionsBloc.close();
  }
}
