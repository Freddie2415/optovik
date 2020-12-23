part of 'search_suggestions_bloc.dart';

abstract class SearchSuggestionsState extends Equatable {
  const SearchSuggestionsState();
}

class SearchSuggestionsInitial extends SearchSuggestionsState {
  @override
  List<Object> get props => [];
}

class HasSearchSuggestions extends SearchSuggestionsState {
  final List<String> suggestions;

  const HasSearchSuggestions({@required this.suggestions})
      : assert(suggestions != null);

  @override
  List<Object> get props => [suggestions];
}
