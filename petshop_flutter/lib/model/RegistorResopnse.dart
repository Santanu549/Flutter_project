import 'package:pet_shop_flutter/model/BaseResponseModel.dart';
import 'package:pet_shop_flutter/model/LoginResponse.dart';

class RegistrationResponse extends BaseResponseModel {
  LoginResponse? data;

  RegistrationResponse({this.data});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      data: json['data'] != null ? LoginResponse.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}
