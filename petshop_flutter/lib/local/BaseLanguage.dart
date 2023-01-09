import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get newest;

  String get appSetting;

  String get language;

  String get other;

  String get changePassword;

  String get privacyPolicy;

  String get helpSupport;

  String get share;

  String get logout;

  String get login;

  String get logoutMsg;

  String get about;

  String get version;

  String get purchase;

  String get contactUs;

  String get editProfile;

  String get confirmImage;

  String get saveSuccessfully;

  String get firstName;

  String get lastName;

  String get email;

  String get shippingAddress;

  String get billingAddress;

  String get sameAsShippingAddress;

  String get sucessfullySaved;

  String get pleaseEnterData;

  String get yes;

  String get cancel;

  String get wishList;

  String get moveToCart;

  String get itemAlreadyInCart;

  String get removeItem;

  String get totalAmount;

  String get checkout;

  String get cart;

  String get checkoutSummary;

  String get orderDetail;

  String get payableAmount;

  String get category;

  String get allPets;

  String get hello;

  String get guestUser;

  String get bestSellingProduct;

  String get saleProduct;

  String get available;

  String get outOfStock;

  String get sale;

  String get goToCart;

  String get addTOCart;

  String get readLess;

  String get readMore;

  String get signIn;

  String get confirmLogOut;

  String get forgotPassword;

  String get noAccount;

  String get register;

  String get resetPassword;

  String get submit;

  String get signUpAccount;

  String get accountCreate;

  String get noInternet;

  String get fieldRequired;

  String get passwordLength;

  String get somethingWrong;

  String get wishListEmpty;

  String get cartEmpty;

  String get orders;

  String get getOrder;

  String get city;

  String get pinCode;

  String get company;

  String get phone;

  String get address1;

  String get address2;

  String get youSaved;

  String get proceedCheckout;

  String get paymentMethod;

  String get payStack;

  String get razorPay;

  String get cashOnDelivery;

  String get proceedPayment;

  String get add;

  String get password;

  String get confirmPassword;

  String get passwordNotMatch;

  String get newPassword;

  String get oldPassword;

  String get userName;

  String get alreadyAccount;

  String get viewAll;

  String get cancelOrder;

  String get otherItems;

  String get orderId;

  String get moreItems;

  String get byAdmin;

  String get discountOnMrp;

  String get totalMrp;

  String get paymentDetail;

  String get viewDetails;

  String get totalOrderPrice;

  String get deliveryAddress;

  String get filterBy;

  String get clear;

  String get noAttributesYet;

  String get close;

  String get apply;

  String get sortBy;

  String get price;

  String get slideThemeMode;

  String get light;

  String get dark;

  String get system;

  String get theme;

  String get home;

  String get profile;

  String get noConnection;
}
