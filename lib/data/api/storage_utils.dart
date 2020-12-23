import 'package:optovik/data/api/service/search_suggestion_service.dart';

class StorageUtils {
  final SearchSuggestionService _searchSuggestionService;

  StorageUtils(this._searchSuggestionService);

  Future<void> setSearchSuggestions(List<String> list) async {
    await _searchSuggestionService.setSuggestions(list);
  }

  Future<List<String>> getSearchSuggestions() async {
    return await _searchSuggestionService.getSuggestions();
  }

  Future<void> clearSearchSuggestions() async {
    await _searchSuggestionService.clearSuggestions();
  }
}
