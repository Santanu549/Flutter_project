import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';

class CustomerUpdate {
  ShippingModel? billing;
  String? first_name;
  String? last_name;
  ShippingModel? shipping;

  CustomerUpdate({
    this.billing,
    this.first_name,
    this.last_name,
    this.shipping,
  });

  factory CustomerUpdate.fromJson(Map<String, dynamic> json) {
    return CustomerUpdate(
      billing: json['billing'] != null ? ShippingModel.fromJson(json['billing']) : null,
      first_name: json['first_name'],
      last_name: json['last_name'],
      shipping: json['shipping'] != null ? ShippingModel.fromJson(json['shipping']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    return data;
  }
}
