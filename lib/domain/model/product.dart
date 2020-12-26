import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optovik/domain/model/category.dart';

class Product extends Equatable {
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
  final List<String> images;
  final String unit;
  final List<Category> categories;
  final String promo = "";

  final int qty;

  const Product({
    @required this.id,
    @required this.created,
    @required this.status,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.showPrice,
    @required this.discount,
    @required this.discountType,
    @required this.guaranty,
    @required this.keywords,
    @required this.inStock,
    @required this.article,
    @required this.isHost,
    @required this.model,
    @required this.short,
    @required this.lastPriceUpdate,
    @required this.count,
    @required this.manufacturer,
    @required this.images,
    @required this.unit,
    @required this.categories,
    this.qty = 0,
  });

  String get image => images.isEmpty ? null : images[0];

  @override
  List<Object> get props => [
        id,
        created,
        status,
        title,
        description,
        price,
        showPrice,
        discount,
        discountType,
        guaranty,
        keywords,
        inStock,
        article,
        isHost,
        model,
        short,
        lastPriceUpdate,
        count,
        manufacturer
      ];

  Product copyWith({@required int qty}) {
    return Product(
      id: this.id,
      created: this.created,
      status: this.status,
      title: this.title,
      description: this.description,
      price: this.price,
      showPrice: this.showPrice,
      discount: this.discount,
      discountType: this.discountType,
      guaranty: this.guaranty,
      keywords: this.keywords,
      inStock: this.inStock,
      article: this.article,
      isHost: this.isHost,
      model: this.model,
      short: this.short,
      lastPriceUpdate: this.lastPriceUpdate,
      count: this.count,
      manufacturer: this.manufacturer,
      images: this.images,
      unit: this.unit,
      categories: this.categories,
      qty: qty,
    );
  }

  @override
  String toString() {
    return "{name => $title | qty => $qty}";
  }
}
