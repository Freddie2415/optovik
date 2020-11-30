import 'package:optovik/data/api/api_utils.dart';
import 'package:optovik/domain/model/category.dart';
import 'package:optovik/domain/repository/category_repository.dart';

class CategoryDataRepository extends CategoryRepository {
  final ApiUtil _apiUtil;

  CategoryDataRepository(this._apiUtil);

  @override
  Future<List<Category>> getCategories() async {
    return _apiUtil.getCategories();
  }
}
