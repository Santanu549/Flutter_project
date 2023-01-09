import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class CartModel {
  int? total_quantity;
  List<CartData>? data;

  CartModel({this.total_quantity, this.data});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      total_quantity: json['total_quantity'],
      data: json['data'] != null ? (json['data'] as List).map((e) => CartData.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['total_quantity'] = this.total_quantity;
    data['data'] = this.data;

    return data;
  }
}

class CartData {
  String? cart_id;
  String? created_at;
  String? full;
  List<String>? gallery;
  String? name;
  bool? on_sale;
  String? price;
  int? pro_id;
  String? quantity;
  String? regular_price;
  String? sale_price;
  String? shipping_class;
  int? shipping_class_id;
  String? sku;
  int? stock_quantity;
  String? stock_status;
  String? thumbnail;
  String? ps_product_type;
  String? description;

  bool get isAccessory => ps_product_type == ProductTypeAccessories;

  bool get isPet => ps_product_type == ProductTypePet;

  double get discountPrice => sale_price.validate().isNotEmpty ? (regular_price.validate().toDouble() - sale_price.validate().toDouble()) : 0;

  CartData({
    this.cart_id,
    this.created_at,
    this.full,
    this.gallery,
    this.name,
    this.on_sale,
    this.price,
    this.pro_id,
    this.quantity = '1',
    this.regular_price,
    this.sale_price,
    this.shipping_class,
    this.shipping_class_id,
    this.sku,
    this.stock_quantity,
    this.stock_status,
    this.thumbnail,
    this.ps_product_type,
    this.description,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cart_id: json['cart_id'],
      created_at: json['created_at'],
      full: json['full'],
      gallery: json['gallery'] != null ? new List<String>.from(json['gallery']) : null,
      name: json['name'],
      on_sale: json['on_sale'],
      price: json['price'],
      pro_id: json['pro_id'],
      quantity: json['quantity'] ?? '1',
      regular_price: json['regular_price'],
      sale_price: json['sale_price'],
      shipping_class: json['shipping_class'],
      shipping_class_id: json['shipping_class_id'],
      sku: json['sku'],
      stock_quantity: json['stock_quantity'],
      stock_status: json['stock_status'],
      thumbnail: json['thumbnail'],
      ps_product_type: json['ps_product_type'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cart_id;
    data['created_at'] = this.created_at;
    data['full'] = this.full;
    data['name'] = this.name;
    data['on_sale'] = this.on_sale;
    data['price'] = this.price;
    data['pro_id'] = this.pro_id;
    data['quantity'] = this.quantity;
    data['regular_price'] = this.regular_price;
    data['sale_price'] = this.sale_price;
    data['shipping_class'] = this.shipping_class;
    data['shipping_class_id'] = this.shipping_class_id;
    data['sku'] = this.sku;
    data['stock_status'] = this.stock_status;
    data['thumbnail'] = this.thumbnail;
    if (this.gallery != null) {
      data['gallery'] = this.gallery;
    }
    if (this.stock_quantity != null) {
      data['stock_quantity'] = this.stock_quantity;
    }
    data['ps_product_type'] = this.ps_product_type;
    data['description'] = this.description;

    return data;
  }
}

class CartListItemModel {
  String? proId;
  String? quantity;

  CartListItemModel({this.proId, this.quantity});

  factory CartListItemModel.fromJson(Map<String, dynamic> json) {
    return CartListItemModel(
      proId: json['pro_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['pro_id'] = this.proId;
    data['quantity'] = this.quantity;

    return data;
  }
}
