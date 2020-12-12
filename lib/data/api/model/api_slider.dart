class ApiSlider {
  final String photo;

  ApiSlider(this.photo);

  static List<ApiSlider> fromApi(List list) {
    return list.map((e) => ApiSlider(e['photo'].toString())).toList();
  }
}
