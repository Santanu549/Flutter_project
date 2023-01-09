import 'package:pet_shop_flutter/model/product/Image.dart';

class UpsellId {
  int? id;
  List<Image>? images;
  String? name;
  String? price;
  String? regular_price;
  String? sale_price;
  String? slug;

  UpsellId({
    this.id,
    this.images,
    this.name,
    this.price,
    this.regular_price,
    this.sale_price,
    this.slug,
  });

  factory UpsellId.fromJson(Map<String, dynamic> json) {
    return UpsellId(
      id: json['id'],
      images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
      name: json['name'],
      price: json['price'],
      regular_price: json['regular_price'],
      sale_price: json['sale_price'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['regular_price'] = this.regular_price;
    data['sale_price'] = this.sale_price;
    data['slug'] = this.slug;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
