import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';

class CreateOrderRequestModel {
  List<LineItemsRequest>? lineItems = [];
  ShippingModel? shipping;
  ShippingModel? billing;
  int? customerId;
  String? paymentMethod;
  var status;
  var setPaid;
  var transactionId;

  CreateOrderRequestModel({this.setPaid, this.status, this.lineItems, this.shipping, this.billing, this.customerId, this.paymentMethod, this.transactionId});

  CreateOrderRequestModel.fromJson(Map<String, dynamic> json) {
    setPaid = json['set_paid'];
    status = json['status'];
    if (json['line_items'] != null) {
      lineItems = <LineItemsRequest>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new LineItemsRequest.fromJson(v));
      });
    }

    shipping = json['shipping'] != null ? new ShippingModel.fromJson(json['shipping']) : null;
    billing = json['billing'] != null ? new ShippingModel.fromJson(json['billing']) : null;
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['set_paid'] = this.setPaid;
    data['status'] = this.status;
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    data['shipping'] = this.shipping;
    data['billing'] = this.billing;
    data['payment_method'] = this.paymentMethod;
    data['transaction_id'] = this.transactionId;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class LineItemsRequest {
  int? productId;
  String? quantity;
  int? variationId;

  LineItemsRequest({this.productId, this.quantity, this.variationId});

  factory LineItemsRequest.fromJson(Map<String, dynamic> json) {
    return LineItemsRequest(productId: json['product_id'], quantity: json['quantity'], variationId: json['variation_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['variation_id'] = this.variationId;
    return data;
  }
}
