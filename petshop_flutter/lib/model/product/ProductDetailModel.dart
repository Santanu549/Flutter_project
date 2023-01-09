import 'package:pet_shop_flutter/model/product/Category.dart';
import 'package:pet_shop_flutter/model/product/Image.dart';
import 'package:pet_shop_flutter/model/product/UpsellId.dart';

class ProductDetailModel {
  List<Attributes>? attributes;
  String? average_rating;
  bool? backordered;
  String? backorders;
  bool? backorders_allowed;
  String? button_text;
  String? catalog_visibility;
  List<Category>? categories;
  List<int>? cross_sell_ids;
  String? date_created;
  String? date_modified;
  String? date_on_sale_from;
  String? date_on_sale_to;
  List<Object>? default_attributes;
  String? description;
  Dimensions? dimensions;
  int? download_expiry;
  int? download_limit;
  String? download_type;
  bool? downloadable;
  List<Object>? downloads;
  String? external_url;
  bool? featured;
  List<Object>? grouped_products;
  int? id;
  List<Image>? images;
  bool? in_stock;
  bool? is_added_cart;
  bool? is_added_wishlist;
  bool? manage_stock;
  int? menu_order;
  String? name;
  bool? on_sale;
  int? parent_id;
  String? permalink;
  String? price;
  String? price_html;
  bool? purchasable;
  String? purchase_note;
  int? rating_count;
  String? regular_price;
  List<int>? related_ids;
  bool? reviews_allowed;
  String? sale_price;
  String? shipping_class;
  var shipping_class_id;
  bool? shipping_required;
  bool? shipping_taxable;
  String? short_description;
  String? sku;
  String? slug;
  bool? sold_individually;
  String? status;
  Object? stock_quantity;
  List<Object>? tags;
  String? tax_class;
  String? tax_status;
  var total_sales;
  String? type;
  List<UpsellId>? upsell_id;
  List<int>? upsell_ids;
  List<Object>? variations;
  bool? virtual;
  String? weight;
  String? ps_product_type;

  ProductDetailModel({
    this.attributes,
    this.average_rating,
    this.backordered,
    this.backorders,
    this.backorders_allowed,
    this.button_text,
    this.catalog_visibility,
    this.categories,
    this.cross_sell_ids,
    this.date_created,
    this.date_modified,
    this.date_on_sale_from,
    this.date_on_sale_to,
    this.default_attributes,
    this.description,
    this.dimensions,
    this.download_expiry,
    this.download_limit,
    this.download_type,
    this.downloadable,
    this.downloads,
    this.external_url,
    this.featured,
    this.grouped_products,
    this.id,
    this.images,
    this.in_stock,
    this.is_added_cart,
    this.is_added_wishlist,
    this.manage_stock,
    this.menu_order,
    this.name,
    this.on_sale,
    this.parent_id,
    this.permalink,
    this.price,
    this.price_html,
    this.purchasable,
    this.purchase_note,
    this.rating_count,
    this.regular_price,
    this.related_ids,
    this.reviews_allowed,
    this.sale_price,
    this.shipping_class,
    this.shipping_class_id,
    this.shipping_required,
    this.shipping_taxable,
    this.short_description,
    this.sku,
    this.slug,
    this.sold_individually,
    this.status,
    this.stock_quantity,
    this.tags,
    this.tax_class,
    this.tax_status,
    this.total_sales,
    this.type,
    this.upsell_id,
    this.upsell_ids,
    this.variations,
    this.virtual,
    this.weight,
    this.ps_product_type,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      attributes: json['attributes'] != null ? (json['attributes'] as List).map((i) => Attributes.fromJson(i)).toList() : null,
      average_rating: json['average_rating'],
      backordered: json['backordered'],
      backorders: json['backorders'],
      backorders_allowed: json['backorders_allowed'],
      button_text: json['button_text'],
      catalog_visibility: json['catalog_visibility'],
      categories: json['categories'] != null ? (json['categories'] as List).map((i) => Category.fromJson(i)).toList() : null,
      cross_sell_ids: json['cross_sell_ids'] != null ? new List<int>.from(json['cross_sell_ids']) : null,
      date_created: json['date_created'],
      date_modified: json['date_modified'],
      date_on_sale_from: json['date_on_sale_from'],
      date_on_sale_to: json['date_on_sale_to'],
      // default_attributes: json['default_attributes'] != null ? (json['default_attributes'] as List).map((i) => Object.fromJson(i)).toList() : null,
      description: json['description'],
      dimensions: json['dimensions'] != null ? Dimensions.fromJson(json['dimensions']) : null,
      download_expiry: json['download_expiry'],
      download_limit: json['download_limit'],
      download_type: json['download_type'],
      downloadable: json['downloadable'],
      // downloads: json['downloads'] != null ? (json['downloads'] as List).map((i) => Object.fromJson(i)).toList() : null,
      external_url: json['external_url'],
      featured: json['featured'],
      // grouped_products: json['grouped_products'] != null ? (json['grouped_products'] as List).map((i) => Object.fromJson(i)).toList() : null,
      id: json['id'],
      images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
      in_stock: json['in_stock'],
      is_added_cart: json['is_added_cart'],
      is_added_wishlist: json['is_added_wishlist'],
      manage_stock: json['manage_stock'],
      menu_order: json['menu_order'],
      name: json['name'],
      on_sale: json['on_sale'],
      parent_id: json['parent_id'],
      permalink: json['permalink'],
      price: json['price'],
      price_html: json['price_html'],
      purchasable: json['purchasable'],
      purchase_note: json['purchase_note'],
      rating_count: json['rating_count'],
      regular_price: json['regular_price'],
      related_ids: json['related_ids'] != null ? new List<int>.from(json['related_ids']) : null,
      reviews_allowed: json['reviews_allowed'],
      sale_price: json['sale_price'],
      shipping_class: json['shipping_class'],
      shipping_class_id: json['shipping_class_id'],
      shipping_required: json['shipping_required'],
      shipping_taxable: json['shipping_taxable'],
      short_description: json['short_description'],
      sku: json['sku'],
      slug: json['slug'],
      sold_individually: json['sold_individually'],
      status: json['status'],
      // stock_quantity: json['stock_quantity'] != null ? Object.fromJson(json['stock_quantity']) : null,
      // tags: json['tags'] != null ? (json['tags'] as List).map((i) => Object.fromJson(i)).toList() : null,
      tax_class: json['tax_class'],
      tax_status: json['tax_status'],
      total_sales: json['total_sales'],
      type: json['type'],
      upsell_id: json['upsell_id'] != null ? (json['upsell_id'] as List).map((i) => UpsellId.fromJson(i)).toList() : null,
      upsell_ids: json['upsell_ids'] != null ? new List<int>.from(json['upsell_ids']) : null,
      // variations: json['variations'] != null ? (json['variations'] as List).map((i) => Object.fromJson(i)).toList() : null,
      virtual: json['virtual'],
      weight: json['weight'],
      ps_product_type: json['ps_product_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average_rating'] = this.average_rating;
    data['backordered'] = this.backordered;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backorders_allowed;
    data['button_text'] = this.button_text;
    data['catalog_visibility'] = this.catalog_visibility;
    data['date_created'] = this.date_created;
    data['date_modified'] = this.date_modified;
    data['date_on_sale_from'] = this.date_on_sale_from;
    data['date_on_sale_to'] = this.date_on_sale_to;
    data['description'] = this.description;
    data['download_expiry'] = this.download_expiry;
    data['download_limit'] = this.download_limit;
    data['download_type'] = this.download_type;
    data['downloadable'] = this.downloadable;
    data['external_url'] = this.external_url;
    data['featured'] = this.featured;
    data['id'] = this.id;
    data['in_stock'] = this.in_stock;
    data['is_added_cart'] = this.is_added_cart;
    data['is_added_wishlist'] = this.is_added_wishlist;
    data['manage_stock'] = this.manage_stock;
    data['menu_order'] = this.menu_order;
    data['name'] = this.name;
    data['on_sale'] = this.on_sale;
    data['parent_id'] = this.parent_id;
    data['permalink'] = this.permalink;
    data['price'] = this.price;
    data['price_html'] = this.price_html;
    data['purchasable'] = this.purchasable;
    data['purchase_note'] = this.purchase_note;
    data['rating_count'] = this.rating_count;
    data['regular_price'] = this.regular_price;
    data['reviews_allowed'] = this.reviews_allowed;
    data['sale_price'] = this.sale_price;
    data['shipping_class'] = this.shipping_class;
    data['shipping_class_id'] = this.shipping_class_id;
    data['shipping_required'] = this.shipping_required;
    data['shipping_taxable'] = this.shipping_taxable;
    data['short_description'] = this.short_description;
    data['sku'] = this.sku;
    data['slug'] = this.slug;
    data['sold_individually'] = this.sold_individually;
    data['status'] = this.status;
    data['tax_class'] = this.tax_class;
    data['tax_status'] = this.tax_status;
    data['total_sales'] = this.total_sales;
    data['type'] = this.type;
    data['virtual'] = this.virtual;
    data['weight'] = this.weight;
    if (this.attributes != null) {
      // data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.cross_sell_ids != null) {
      data['cross_sell_ids'] = this.cross_sell_ids;
    }
    if (this.default_attributes != null) {
      // data['default_attributes'] = this.default_attributes!.map((v) => v.toJson()).toList();
    }
    if (this.dimensions != null) {
      // data['dimensions'] = this.dimensions.toJson();
    }
    if (this.downloads != null) {
      // data['downloads'] = this.downloads!.map((v) => v.toJson()).toList();
    }
    if (this.grouped_products != null) {
      // data['grouped_products'] = this.grouped_products!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.related_ids != null) {
      data['related_ids'] = this.related_ids;
    }
    if (this.stock_quantity != null) {
      // data['stock_quantity'] = this.stock_quantity.toJson();
    }
    if (this.tags != null) {
      // data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.upsell_id != null) {
      data['upsell_id'] = this.upsell_id!.map((v) => v.toJson()).toList();
    }
    if (this.upsell_ids != null) {
      data['upsell_ids'] = this.upsell_ids;
    }
    if (this.variations != null) {
      // data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    data['ps_product_type'] = this.ps_product_type;
    return data;
  }
}

class Dimensions {
  String? height;
  String? length;
  String? width;

  Dimensions({this.height, this.length, this.width});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      height: json['height'],
      length: json['length'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['length'] = this.length;
    data['width'] = this.width;
    return data;
  }
}

class Attributes {
  var id;
  String? name;
  List<String>? options;
  var position;
  bool? variation;
  bool? visible;

  Attributes({this.id, this.name, this.options, this.position, this.variation, this.visible});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      id: json['id'],
      name: json['name'],
      options: json['options'] != null ? new List<String>.from(json['options']) : null,
      position: json['position'],
      variation: json['variation'],
      visible: json['visible'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['variation'] = this.variation;
    data['visible'] = this.visible;
    if (this.options != null) {
      data['options'] = this.options;
    }
    return data;
  }
}
