import 'package:optovik/data/api/model/api_category.dart';
import 'package:optovik/domain/model/category.dart';

class CategoryMapper {
  static Category fromApi(ApiCategory category) {
    return Category(
      id: category.id,
      name: category.name,
      icon: category.icon,
      priority: category.priority,
      children: fromApiList(category.children),
    );
  }

  static List<Category> fromApiList(List<ApiCategory> list) {
    return list.map(CategoryMapper.fromApi).toList();
  }
}
