part of 'search_suggestions_bloc.dart';

abstract class SearchSuggestionsEvent extends Equatable {
  const SearchSuggestionsEvent();

  @override
  List<Object> get props => [];
}

class GetSearchSuggestions extends SearchSuggestionsEvent {}

class CleanSuggestions extends SearchSuggestionsEvent {}
