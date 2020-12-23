import 'package:meta/meta.dart';

class ProductsParams {
  final String format = 'json';
  final limit;
  final page;
  final categoryId;
  final String ordering;
  final String search;

  ProductsParams({
    @required this.limit,
    @required this.page,
    this.categoryId,
    this.ordering,
    this.search=''
  });

  toRequestParams() {
    Map<String, String> params = Map<String, String>();
    params.addAll({'ordering': ordering});
    params.addAll({'format': format});
    params.addAll({'limit': '$limit'});
    params.addAll({'page': '$page'});
    params.addAll({"search": search});
    if (categoryId != null) {
      params.addAll({'cat_one': '$categoryId'});
    }
    return params;
  }
}
