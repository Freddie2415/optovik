enum SortType {
  default_sort,
  name_asc,
  name_desc,
}

class Sort {
  final SortType sortType;

  const Sort({this.sortType = SortType.default_sort});

  @override
  String toString() {
    switch (sortType) {
      case SortType.default_sort:
        return '-pk';
        break;
      case SortType.name_asc:
        return 'title';
        break;
      case SortType.name_desc:
        return '-title';
        break;
      default: return '-pk';
    }
  }
}
