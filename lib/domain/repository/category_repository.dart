import 'package:optovik/domain/model/category.dart';


abstract class CategoryRepository{
  Future<List<Category>> getCategories();
}