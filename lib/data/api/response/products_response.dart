import 'package:meta/meta.dart';
import 'package:optovik/domain/model/product.dart';

class ProductsResponse {
  final nextPage;
  final nextUrl;
  final List<Product> products;

  ProductsResponse({
    @required this.nextPage,
    @required this.nextUrl,
    @required this.products,
  });
}
