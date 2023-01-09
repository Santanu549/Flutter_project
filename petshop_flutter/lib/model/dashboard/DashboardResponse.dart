import 'package:pet_shop_flutter/model/dashboard/CategoryModel.dart';
import 'package:pet_shop_flutter/model/dashboard/CurrencySymbolModel.dart';
import 'package:pet_shop_flutter/model/dashboard/SocialLink.dart';
import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';

class DashboardResponse {
  String? app_lang;
  List<BannerImg>? banner;
  List<ProductDetailModel>? best_selling_product;
  List<CategoryModel>? category;
  CurrencySymbolModel? currency_symbol;
  List<ProductDetailModel>? deal_of_the_day;
  bool? enable_coupons;
  List<ProductDetailModel>? featured;
  bool? is_dokan_active;
  List<ProductDetailModel>? newest;
  List<ProductDetailModel>? offer;
  String? payment_method;
  List<ProductDetailModel>? sale_product;
  List<SaleBanner>? salebanner;
  SocialLink? social_link;
  List<ProductDetailModel>? suggested_for_you;
  List<Object>? vendors;
  List<ProductDetailModel>? you_may_like;

  DashboardResponse({
    this.app_lang,
    this.banner,
    this.best_selling_product,
    this.category,
    this.currency_symbol,
    this.deal_of_the_day,
    this.enable_coupons,
    this.featured,
    this.is_dokan_active,
    this.newest,
    this.offer,
    this.payment_method,
    this.sale_product,
    this.salebanner,
    this.social_link,
    this.suggested_for_you,
    this.vendors,
    this.you_may_like,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      app_lang: json['app_lang'],
      banner: json['banner'] != null ? (json['banner'] as List).map((i) => BannerImg.fromJson(i)).toList() : null,
      best_selling_product: json['best_selling_product'] != null ? (json['best_selling_product'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
      sale_product: json['sale_product'] != null ? (json['sale_product'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
      category: json['category'] != null ? (json['category'] as List).map((i) => CategoryModel.fromJson(i)).toList() : null,
      currency_symbol: json['currency_symbol'] != null ? CurrencySymbolModel.fromJson(json['currency_symbol']) : null,
      deal_of_the_day: json['deal_of_the_day'] != null ? (json['deal_of_the_day'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
      enable_coupons: json['enable_coupons'],
      featured: json['featured'] != null ? (json['featured'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
      is_dokan_active: json['is_dokan_active'],
      newest: json['newest'] != null ? (json['newest'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
      // offer: json['offer'] != null ? (json['offer'] as List).map((i) => Object.fromJson(i)).toList() : null,
      payment_method: json['payment_method'],
      salebanner: json['salebanner'] != null ? (json['salebanner'] as List).map((i) => SaleBanner.fromJson(i)).toList() : null,
      social_link: json['social_link'] != null ? SocialLink.fromJson(json['social_link']) : null,
      suggested_for_you: json['suggested_for_you'] != null ? (json['suggested_for_you'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
      // vendors: json['vendors'] != null ? (json['vendors'] as List).map((i) => Object.fromJson(i)).toList() : null,
      you_may_like: json['you_may_like'] != null ? (json['you_may_like'] as List).map((i) => ProductDetailModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_lang'] = this.app_lang;
    data['enable_coupons'] = this.enable_coupons;
    data['is_dokan_active'] = this.is_dokan_active;
    data['payment_method'] = this.payment_method;
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    if (this.best_selling_product != null) {
      data['best_selling_product'] = this.best_selling_product!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.currency_symbol != null) {
      data['currency_symbol'] = this.currency_symbol!.toJson();
    }
    if (this.deal_of_the_day != null) {
      data['deal_of_the_day'] = this.deal_of_the_day!.map((v) => v.toJson()).toList();
    }
    if (this.featured != null) {
      data['featured'] = this.featured!.map((v) => v.toJson()).toList();
    }
    if (this.newest != null) {
      data['newest'] = this.newest!.map((v) => v.toJson()).toList();
    }
    if (this.offer != null) {
      data['offer'] = this.offer!.map((v) => v.toJson()).toList();
    }
    if (this.sale_product != null) {
      data['sale_product'] = this.sale_product!.map((v) => v.toJson()).toList();
    }
    if (this.salebanner != null) {
      data['salebanner'] = this.salebanner!.map((v) => v.toJson()).toList();
    }
    if (this.social_link != null) {
      data['social_link'] = this.social_link!.toJson();
    }
    if (this.suggested_for_you != null) {
      data['suggested_for_you'] = this.suggested_for_you!.map((v) => v.toJson()).toList();
    }
    if (this.vendors != null) {
      // data['vendors'] = this.vendors!.map((v) => v.toJson()).toList();
    }
    if (this.you_may_like != null) {
      data['you_may_like'] = this.you_may_like!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerImg {
  String? desc;
  String? image;
  String? thumb;
  String? url;

  BannerImg({
    this.desc,
    this.image,
    this.thumb,
    this.url,
  });

  factory BannerImg.fromJson(Map<String, dynamic> json) {
    return BannerImg(
      desc: json['desc'],
      image: json['image'],
      thumb: json['thumb'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['thumb'] = this.thumb;
    data['url'] = this.url;
    return data;
  }
}

class SaleBanner {
  String? end_date;
  String? image;
  String? start_date;
  String? thumb;
  String? title;

  SaleBanner({this.end_date, this.image, this.start_date, this.thumb, this.title});

  factory SaleBanner.fromJson(Map<String, dynamic> json) {
    return SaleBanner(
      end_date: json['end_date'],
      image: json['image'],
      start_date: json['start_date'],
      thumb: json['thumb'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_date'] = this.end_date;
    data['image'] = this.image;
    data['start_date'] = this.start_date;
    data['thumb'] = this.thumb;
    data['title'] = this.title;
    return data;
  }
}
