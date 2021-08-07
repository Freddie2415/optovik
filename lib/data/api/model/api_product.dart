import 'package:optovik/data/api/model/api_category.dart';

class ApiProduct {
  final int id;
  final String created;
  final bool status;
  final String title;
  final String description;
  final double price;
  final double showPrice;
  final double discount;
  final String discountType;
  final dynamic guaranty;
  final String keywords;
  final bool inStock;
  final String article;
  final bool isHost;
  final dynamic model;
  final String short;
  final String lastPriceUpdate;
  final int count;
  final int manufacturer;
  final List<String> photos;
  final List<ApiCategory> categories;

  const ApiProduct(
      {this.id,
      this.created,
      this.status,
      this.title,
      this.description,
      this.price,
      this.showPrice,
      this.discount,
      this.discountType,
      this.guaranty,
      this.keywords,
      this.inStock,
      this.article,
      this.isHost,
      this.model,
      this.short,
      this.lastPriceUpdate,
      this.count,
      this.manufacturer,
      this.photos,
      this.categories});

  static List<ApiProduct> fromApi(List items) {
    if (items == null) {
      return [];
    }
    return items.map((p) {
      final photos = (p['photos'] as List).map((e) => e.toString()).toList();
      final categories = (p['cat_one'] as List)
          .map((e) => ApiCategory(id: e['id'], name: e['name_ru']))
          .toList() ?? [];

      return ApiProduct(
          id: p['id'],
          title: p['title_ru'],
          article: p['article'],
          count: p['count'],
          created: p['created'],
          description: p['description_ru'],
          discount: p['discount'],
          discountType: p['discount_type'],
          guaranty: p['guaranty'],
          inStock: p['in_stock'],
          isHost: p['is_host'],
          keywords: p['keywords'],
          lastPriceUpdate: p['last_price_update'],
          manufacturer: p['manufacturer'],
          model: p['model'],
          price: p['price'],
          short: p['short'],
          showPrice: p['show_price'],
          status: p['status'],
          photos: photos,
          categories: categories);
    }).toList();
  }
}
