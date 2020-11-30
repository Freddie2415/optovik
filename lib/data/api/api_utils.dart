import 'package:optovik/data/api/service/category_service.dart';
import 'package:optovik/data/mapper/category_mapper.dart';
import 'package:optovik/domain/model/category.dart';

class ApiUtil {
  final CategoryService _categoryService;

  ApiUtil(this._categoryService);

  Future<List<Category>> getCategories() async {
    final result = await _categoryService.getCategories();
    return CategoryMapper.fromApiList(result);
  }
}
