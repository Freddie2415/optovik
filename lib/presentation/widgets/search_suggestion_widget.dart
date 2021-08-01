import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/search_sugesstions/search_suggestions_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/pages/products.dart';
import 'package:optovik/presentation/widgets/my_separator.dart';

class SearchSuggestionsWidget extends StatelessWidget {
  final SearchSuggestionsBloc _searchSuggestionsBloc;

  const SearchSuggestionsWidget(this._searchSuggestionsBloc, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: BlocBuilder<SearchSuggestionsBloc, SearchSuggestionsState>(
        cubit: _searchSuggestionsBloc..add(GetSearchSuggestions()),
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, SearchSuggestionsState state) {
    if (state is HasSearchSuggestions) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                S.of(context).recentRequests,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextButton(
                onPressed: () => _searchSuggestionsBloc.add(CleanSuggestions()),
                child: Text(
                  S.of(context).clear,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            ],
          ),
          DashSeparator(color: Colors.grey),
          Column(
            children: state.suggestions
                .map((e) => SuggestionTileWidget(
                      title: e,
                      onTap: () {
                        Navigator.of(context).push(ProductsPage.route(
                          query: e,
                          title: e,
                          categoryId: null,
                          isSearchPage: false,
                        ));
                      },
                    ))
                .toList(),
          )
        ],
      );
    } else {
      return Container(color: Colors.lightGreen);
    }
  }
}

class SuggestionTileWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const SuggestionTileWidget({Key key, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            title,
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
          dense: true,
        ),
        DashSeparator(
          color: Colors.grey,
        ),
      ],
    );
  }
}
