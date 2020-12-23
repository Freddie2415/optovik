import 'package:shared_preferences/shared_preferences.dart';

class SearchSuggestionService {
  static const String _KEY = "searchSuggestions";
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  Future<List<String>> getSuggestions() async {
    final prefs = await _sharedPreferences;
    return prefs.getStringList(_KEY) ?? [];
  }

  Future<void> setSuggestions(List<String> list) async {
    final prefs = await _sharedPreferences;
    prefs.setStringList(_KEY, list);
  }

  Future<void> clearSuggestions() async {
    final prefs = await _sharedPreferences;
    prefs.remove(_KEY);
  }
}
