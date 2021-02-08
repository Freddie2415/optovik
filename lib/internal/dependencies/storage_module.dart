import 'package:optovik/data/api/service/cart_service.dart';
import 'package:optovik/data/api/service/search_suggestion_service.dart';
import 'package:optovik/data/api/storage_utils.dart';

class StorageModule {
  static StorageUtils _storageUtils;

  static StorageUtils storageUtil() {
    if (_storageUtils == null) {
      _storageUtils = StorageUtils(
        SearchSuggestionService(),
        CartService(),
      );
    }
    return _storageUtils;
  }
}
