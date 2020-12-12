import 'package:optovik/domain/model/banner.dart';
import 'package:optovik/domain/model/category.dart';
import 'package:optovik/domain/model/product.dart';

class HomeResponse {
  final List<Banner> banners;
  final List<Category> categories;
  final List<Product> hotDeals;
  final List<Product> hotProducts;
  final List<Product> lastProducts;

  HomeResponse({
    this.banners,
    this.categories,
    this.hotDeals,
    this.hotProducts,
    this.lastProducts,
  });
}
