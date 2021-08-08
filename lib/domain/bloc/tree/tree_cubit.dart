import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/model/category.dart';

part 'tree_state.dart';

class TreeCubit extends Cubit<List<Category>> {
  List<Category> categories;
  Category selectedCategory;
  List<Category> items = [];
  List<Category> tree = [];

  TreeCubit({this.categories = const []}) : super(categories);

  void selectItem(Category item, Function callback) {
    bool useCallback = item.children.isEmpty || isParent(item);

    if (useCallback) {
      return callback();
    }

    item.children.forEach((element) {
      print(element.name);
    });

    selectedCategory = item;
    item.children.remove(selectedCategory);
    item.children.insert(0, selectedCategory);
    items = item.children;
    tree.add(item);
    tree = tree.toSet().toList();
    emit(items);
  }

  void back(Function callback) {
    if (tree.isEmpty) {
      callback();
      close();
      return;
    }

    tree.removeLast();

    if (tree.isEmpty) {
      selectedCategory = null;
      items = categories;

      emit(items);
      return;
    }

    Category category = tree.last;
    category.children.remove(category);
    category.children.insert(0, category);
    selectedCategory = category;
    items = selectedCategory.children;

    emit(items);
  }

  bool isParent(Category item) =>
      selectedCategory != null && selectedCategory == item;

  void setCategories(List<Category> categories) {
    this.categories = categories;
    emit(categories);
  }

  void resetData() {
    categories = [];
    selectedCategory = null;
    items = [];
    tree = [];
  }
}
