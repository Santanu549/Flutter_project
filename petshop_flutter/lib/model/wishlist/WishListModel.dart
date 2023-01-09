class WishListModel {
  String? created_at;
  String? full;
  List<String>? gallery;
  bool? in_stock;
  String? name;
  String? price;
  int? pro_id;
  String? regular_price;
  String? sale_price;
  String? sku;
  int? stock_quantity;
  String? thumbnail;
  String? ps_product_type;

  WishListModel({
    this.created_at,
    this.full,
    this.gallery,
    this.in_stock,
    this.name,
    this.price,
    this.pro_id,
    this.regular_price,
    this.sale_price,
    this.sku,
    this.stock_quantity,
    this.thumbnail,
    this.ps_product_type,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      created_at: json['created_at'],
      full: json['full'],
      gallery: json['gallery'] != null ? new List<String>.from(json['gallery']) : null,
      in_stock: json['in_stock'],
      name: json['name'],
      price: json['price'],
      pro_id: json['pro_id'],
      regular_price: json['regular_price'],
      sale_price: json['sale_price'],
      sku: json['sku'],
      stock_quantity: json['stock_quantity'],
      thumbnail: json['thumbnail'],
      ps_product_type: json['ps_product_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['full'] = this.full;
    data['in_stock'] = this.in_stock;
    data['name'] = this.name;
    data['price'] = this.price;
    data['pro_id'] = this.pro_id;
    data['regular_price'] = this.regular_price;
    data['sale_price'] = this.sale_price;
    data['sku'] = this.sku;
    data['thumbnail'] = this.thumbnail;
    if (this.gallery != null) {
      data['gallery'] = this.gallery;
    }
    if (this.stock_quantity != null) {
      data['stock_quantity'] = this.stock_quantity;
    }
    data['ps_product_type'] = this.ps_product_type;
    return data;
  }
}
