import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';

class ProductListModel {
  List<ProductDetailModel>? data;
  int? num_of_pages;

  ProductListModel({this.data, this.num_of_pages});

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
      num_of_pages: json['num_of_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num_of_pages'] = this.num_of_pages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
