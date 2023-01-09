import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';
import 'package:pet_shop_flutter/model/order/CreateOrderRequestModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/DashboardScreen.dart';

import '../main.dart';
import 'AppColors.dart';
import 'AppConstants.dart';

// PayStack Payment
void payStackPayment(BuildContext context, PaystackPlugin plugin) async {
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;
  CheckoutMethod _method = CheckoutMethod.card;

  Charge charge = Charge()
    ..amount = (double.parse(cartStore.cartTotalPayableAmount.toString()) * 100.00).toInt() // In base currency
    ..email = getStringAsync(USER_EMAIL)
    ..currency = getStringAsync("NGN")
    ..card = PaymentCard(number: _cardNumber, cvc: _cvv, expiryMonth: _expiryMonth, expiryYear: _expiryYear);

  charge.reference = _getReference();
  try {
    CheckoutResponse response = await plugin.checkout(context, method: _method, charge: charge, fullscreen: false, logo: Container()); //_updateStatus(response.reference, response.message);
    if (response.message == "Success") {
      createNativeOrder(context, "PayStackPayment");
    } else {
      snackBar(context, title: "Payment Failed");
    }
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}

String _getReference() {
  String platform;
  if (Platform.isIOS) {
    platform = 'iOS';
  } else {
    platform = 'Android';
  }
  return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
}

// Payment API
void createNativeOrder(BuildContext context, String mPayMethod) async {
  var mBilling = ShippingModel();
  var mShipping = ShippingModel();

  if (appStore.billingAddress != null) {
    mBilling.first_name = appStore.billingAddress!.first_name;
    mBilling.last_name = appStore.billingAddress!.last_name;
    mBilling.email = appStore.billingAddress!.email;
    mBilling.city = appStore.billingAddress!.city;
    mBilling.postcode = appStore.billingAddress!.postcode;
    mBilling.company = appStore.billingAddress!.company;
    mBilling.phone = appStore.billingAddress!.phone;
    mBilling.state = appStore.billingAddress!.state;
    mBilling.country = appStore.billingAddress!.country;
    mBilling.address_1 = appStore.billingAddress!.address_1;
    mBilling.address_2 = appStore.billingAddress!.address_2;
  }

  if (appStore.shippingAddress != null) {
    mShipping.first_name = appStore.shippingAddress!.first_name;
    mShipping.last_name = appStore.shippingAddress!.last_name;
    mShipping.email = appStore.shippingAddress!.email;
    mShipping.city = appStore.shippingAddress!.city;
    mShipping.postcode = appStore.shippingAddress!.postcode;
    mShipping.company = appStore.shippingAddress!.company;
    mShipping.phone = appStore.shippingAddress!.phone;
    mShipping.state = appStore.shippingAddress!.state;
    mShipping.country = appStore.shippingAddress!.country;
    mShipping.address_1 = appStore.shippingAddress!.address_1;
    mShipping.address_2 = appStore.shippingAddress!.address_2;
  }
  List<LineItemsRequest> lineItems = [];
  cartStore.cartList.forEach((item) {
    var lineItem = LineItemsRequest();
    lineItem.productId = item.pro_id;
    lineItem.quantity = item.quantity;
    lineItem.variationId = item.pro_id;
    lineItems.add(lineItem);
  });

  var request = {
    'billing': mBilling,
    'shipping': mShipping,
    'line_items': lineItems,
    'payment_method': mPayMethod,
    'customer_id': appStore.userId.toString(),
    'status': "pending",
    'set_paid': false,
  };
  appStore.setLoading(true);

  createOrderApi(request).then((response) async {
    appStore.setLoading(false);
    createOrderTracking(response['id']);
    await showConfirmDialogCustom(
      context,
      primaryColor: primaryColor,
      title: 'Payment Successfully Done',
      onAccept: (c) {
        clearCartItems().then((response) {
          cartStore.cartList.clear();
          cartStore.cartTotalAmount = 0.0;
          cartStore.cartTotalPayableAmount = 0.0;
          cartStore.cartSavedAmount = 0.0;
          DashboardScreen().launch(context, isNewTask: true);
        }).catchError((error) {
          toast(error.toString());
        });
      },
      onCancel: (c) {
        clearCartItems().then((response) {
          cartStore.cartList.clear();
          cartStore.cartTotalAmount = 0.0;
          cartStore.cartTotalPayableAmount = 0.0;
          cartStore.cartSavedAmount = 0.0;
          DashboardScreen().launch(context, isNewTask: true);
        }).catchError((error) {
          toast(error.toString());
        });
      },
    );
    finish(context);
  }).catchError((error) {
    appStore.setLoading(false);
    // toast(error.toString());
  });
}

Future createOrderTracking(var mOrderId) async {
  appStore.setLoading(true);
  var request = {
    'customer_note': true,
    'note': "{\n" + "\"status\":\"Ordered\",\n" + "\"message\":\"Your order has been placed.\"\n" + "} ",
  };
  await createOrderNotes(mOrderId, request).then((res) {
    appStore.setLoading(false);
  }).catchError((error) {
    appStore.setLoading(false);
    toast(error.toString());
  });
}
