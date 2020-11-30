import 'package:meta/meta.dart';

class Category {
  final int id;
  final String name;
  final int priority;
  final String icon;
  final List<Category> children;

  const Category({
    @required this.id,
    @required this.name,
    @required this.priority,
    @required this.icon,
    @required this.children,
  });

  bool get isMain {
    return this.children != null && this.children.isNotEmpty;
  }

  @override
  String toString() {
    return '$id';
  }
}
