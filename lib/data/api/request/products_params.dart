import 'package:meta/meta.dart';

class ProductsParams {
  final String format = 'json';
  final limit;
  final page;
  final categoryId;

  ProductsParams({
    @required this.limit,
    @required this.page,
    this.categoryId,
  });

  toRequestParams() {
    if (categoryId != null) {
      return {
        'format': format,
        'limit': '$limit',
        'page': '$page',
        'cat_one': '$categoryId',
      };
    }
    return {
      'format': format,
      'limit': '$limit',
      'page': '$page',
    };
  }
}
