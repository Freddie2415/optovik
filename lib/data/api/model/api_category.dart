class ApiCategory {
  final int id;
  final String name;
  final int priority;
  final String icon;
  final List<ApiCategory> children;

  ApiCategory({
    this.id,
    this.name,
    this.priority,
    this.icon,
    this.children = const [],
  });

  static ApiCategory fromApi(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    return ApiCategory(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      icon: map['icon'],
      children: fromArrayApi(map['children']),
    );
  }

  static List<ApiCategory> fromApiHome(List items) {
    return items
        .map((e) => ApiCategory(
              id: e['id'],
              icon: e['icon'],
              name: e['i18n']['name_ru'],
            ))
        .toList();
  }

  static List<ApiCategory> fromArrayApi(List items) {
    if (items == null) {
      return [];
    }
    return items.map((e) => fromApi(e)).toList();
  }

  @override
  String toString() {
    return '$id';
  }
}
