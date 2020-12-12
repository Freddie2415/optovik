import 'package:optovik/data/api/model/api_product.dart';
import 'package:optovik/domain/model/product.dart';

class ProductMapper {
  static List<Product> fromApiList(List<ApiProduct> list) {
    return list
        .map(
          (e) => Product(
            id: e.id,
            status: e.status,
            showPrice: e.showPrice,
            short: e.short,
            price: e.price,
            model: e.model,
            manufacturer: e.manufacturer,
            lastPriceUpdate: e.lastPriceUpdate,
            keywords: e.keywords,
            isHost: e.isHost,
            inStock: e.inStock,
            guaranty: e.guaranty,
            discountType: e.discountType,
            discount: e.discount,
            description: e.description,
            created: e.created,
            count: e.count,
            article: e.article,
            title: e.title,
            images: e.photos,
            unit: '' // TODO: Unit!!!!
          ),
        )
        .toList();
  }
}
