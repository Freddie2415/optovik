import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optovik/domain/repository/product_repository.dart';

part 'search_suggestions_event.dart';

part 'search_suggestions_state.dart';

class SearchSuggestionsBloc
    extends Bloc<SearchSuggestionsEvent, SearchSuggestionsState> {
  SearchSuggestionsBloc(this._productRepository)
      : super(SearchSuggestionsInitial());

  final ProductRepository _productRepository;

  @override
  Stream<SearchSuggestionsState> mapEventToState(
    SearchSuggestionsEvent event,
  ) async* {
    if (event is GetSearchSuggestions) {
      final List<String> suggestions =
          await _productRepository.getSearchSuggestions();

      if (suggestions != null && suggestions.isNotEmpty) {
        yield HasSearchSuggestions(suggestions: suggestions);
      }
    }

    if (event is CleanSuggestions) {
      await _productRepository.clearSearchSuggestions();
      yield SearchSuggestionsInitial();
    }
  }
}
