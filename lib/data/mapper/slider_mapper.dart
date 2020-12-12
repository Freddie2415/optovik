import 'package:optovik/data/api/model/api_slider.dart';
import 'package:optovik/domain/model/banner.dart';

class SliderMapper {
  static List<Banner> fromApiList(List<ApiSlider> list) =>
      list.map((e) => Banner(e.photo)).toList();
}
