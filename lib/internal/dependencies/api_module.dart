import 'package:optovik/data/api/api_utils.dart';
import 'package:optovik/data/api/service/category_service.dart';

class ApiModule {
  static ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(CategoryService());
    }
    return _apiUtil;
  }
}
