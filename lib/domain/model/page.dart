import 'package:meta/meta.dart';

class Page {
  final String titleRu;
  final String titleUz;
  final String contentRu;
  final String contentUz;
  final int priority;

  String getTitle(String locale) {
    return locale == 'uz' ? titleUz : titleRu;
  }

  String getContent(String locale) {
    return locale == 'uz' ? contentUz : contentRu;
  }

  const Page({
    @required this.titleRu,
    @required this.titleUz,
    @required this.contentRu,
    @required this.contentUz,
    @required this.priority,
  });
}
