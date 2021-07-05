import 'package:meta/meta.dart';

class BannerResponse {
  final num id;
  final String photo;
  final String link;
  final String adType;

  BannerResponse({
    @required this.id,
    @required this.photo,
    @required this.link,
    @required this.adType,
  });
}
