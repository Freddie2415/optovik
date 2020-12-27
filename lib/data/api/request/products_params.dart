import 'package:meta/meta.dart';

class ProductsParams {
  Map<String, dynamic> _params = Map<String, dynamic>();
  final format = 'json';
  final limit;
  final page;
  final categoryId;
  final ordering;
  final search;

  ProductsParams({
    @required this.limit,
    @required this.page,
    this.categoryId,
    this.ordering,
    this.search = '',
  });

  List _ids = [];

  void addParameterId(id) => _ids.add(id.toString());

  Map<String, dynamic> toRequestParams() {
    _params.addAll({'ordering': "$ordering"});
    _params.addAll({'format': "$format"});
    _params.addAll({'limit': "$limit"});
    _params.addAll({'page': "$page"});
    _params.addAll({"search": search});
    if (categoryId != null) {
      _params.addAll({'cat_one': "$categoryId"});
    }
    if (_ids.isNotEmpty) {
      _params.addAll({"id": _ids});
    }
    return _params;
  }
}
