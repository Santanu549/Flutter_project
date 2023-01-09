import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/AttributeModel.dart';
import 'package:pet_shop_flutter/model/ForgotPasswordResponseModel.dart';
import 'package:pet_shop_flutter/model/LoginResponse.dart';
import 'package:pet_shop_flutter/model/ProductListModel.dart';
import 'package:pet_shop_flutter/model/RegistorResopnse.dart';
import 'package:pet_shop_flutter/model/addressModel/CustomerUpdate.dart';
import 'package:pet_shop_flutter/model/cart/CartModel.dart';
import 'package:pet_shop_flutter/model/dashboard/CategoryModel.dart';
import 'package:pet_shop_flutter/model/dashboard/DashboardResponse.dart';
import 'package:pet_shop_flutter/model/order/OrderResponseModel.dart';
import 'package:pet_shop_flutter/model/order/OrderTracking.dart';
import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';
import 'package:pet_shop_flutter/model/wishlist/WishListModel.dart';
import 'package:pet_shop_flutter/network/NetworkUtils.dart';
import 'package:pet_shop_flutter/network/PetShopAPI.dart';
import 'package:pet_shop_flutter/screens/DashboardScreen.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

PetShopAPI petShopAPI = PetShopAPI();
//region Auth
Future<RegistrationResponse> signUpApi({String? firstName, String? lastName, String? userLogin, String? userEmail, String? password}) async {
  Map req = {
    'first_name': firstName.validate(),
    'last_name': lastName.validate(),
    'user_login': userLogin.validate(),
    'user_email': userEmail.validate(),
    'user_pass': password.validate(),
  };
  Response response = await buildHttpResponse('petstore/api/v1/auth/registration', request: req, method: HttpMethod.POST);

  if (!response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') && json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((json) async {
    var loginResponse = RegistrationResponse.fromJson(json);

    Map req = {
      'username': userEmail.validate(),
      'password': password.validate(),
    };
    return await logInApi(req).then((value) async {
      return loginResponse;
    }).catchError((e) {
      throw e.toString();
    });
  }).catchError((e) {
    log(e.toString());
    throw e.toString();
  });
}

Future<LoginResponse> logInApi(Map request, {bool isSocialLogin = false}) async {
  Response response = await buildHttpResponse(isSocialLogin ? 'social-login' : 'jwt-auth/v1/token', request: request, method: HttpMethod.POST);

  if (!response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') && json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((json) async {
    var loginRes = LoginResponse.fromJson(json);

    await appStore.setToken(loginRes.token.validate());
    await appStore.setUserID(loginRes.user_id.validate());
    await appStore.setUserEmail(loginRes.user_email.validate());
    await appStore.setFirstName(loginRes.first_name.validate());
    await appStore.setLastName(loginRes.last_name.validate());
    await appStore.setUserName(loginRes.user_display_name.validate());
    await appStore.setUserPassword(request['password']);
    await appStore.setUserImage(loginRes.avatar.validate());

    if (loginRes.shipping != null) await appStore.setShippingAddress(loginRes.shipping!);
    if (loginRes.billing != null) await appStore.setBillingAddress(loginRes.billing!);

    await appStore.setLogin(true);

    await setValue(USER_PASSWORD, request['password']);

    if (cartStore.cartList.isNotEmpty) {
      addCartItemList(list: cartStore.cartList.map((e) => CartListItemModel(proId: e.pro_id.toString(), quantity: e.quantity)).toList()).then((value) {
        //
      }).catchError((e) {
        snack(e.toString());
      });
    }

    if (wishListStore.wishList.isNotEmpty) wishListStore.wishList.clear();

    return loginRes;
  }).catchError((e) {
    throw e.toString();
  });
}

Future<void> logout(BuildContext context) async {
  await appStore.setLogin(false);

  await appStore.setToken('');
  await appStore.setUserID(0);
  await appStore.setUserEmail('');
  await appStore.setFirstName('');
  await appStore.setLastName('');
  await appStore.setUserName('');
  await appStore.setUserPassword('');
  await appStore.setUserImage('');

  await appStore.setShippingAddress(null);
  await appStore.setBillingAddress(null);

  cartStore.clearCart();
  wishListStore.clearWishlist();
  cartStore.cartTotalPayableAmount = 0.0;
  cartStore.cartTotalAmount = 0.0;
  cartStore.cartSavedAmount = 0.0;

  DashboardScreen().launch(context, isNewTask: true);
}

Future<ForgotPasswordResponseModel> forgotPassword(Map req) async {
  return ForgotPasswordResponseModel.fromJson(await handleResponse(await buildHttpResponse('petstore/api/v1/customer/forget-password', request: req, method: HttpMethod.POST)));
}

Future<ForgotPasswordResponseModel> changePassword(Map req) async {
  return ForgotPasswordResponseModel.fromJson(await handleResponse(await buildHttpResponse('petstore/api/v1/customer/change-password', request: req, method: HttpMethod.POST)));
}
//endregion

Future<DashboardResponse> dashboardApi() async {
  return DashboardResponse.fromJson(await handleResponse(await buildHttpResponse('petstore/api/v1/woocommerce/get-dashboard', method: HttpMethod.GET)));
}

Future<List<CategoryModel>> getAppCategories({int catId = 0}) async {
  Iterable it = (await (handleResponse(await buildHttpResponse('petstore/api/v1/woocommerce/get-sub-category?cat_id=$catId'))));
  return it.map((e) => CategoryModel.fromJson(e)).toList();
}

//region Products
Future<ProductListModel> getProducts(Map req) async {
  return ProductListModel.fromJson(await handleResponse(await buildHttpResponse('petstore/api/v1/woocommerce/get-product', method: HttpMethod.POST, request: req)));
}

Future<List<ProductDetailModel>> getProductDetail({int? productId}) async {
  Iterable it = (await (handleResponse(await buildHttpResponse('petstore/api/v1/woocommerce/get-product-details?product_id=$productId'))));
  return it.map((e) => ProductDetailModel.fromJson(e)).toList();
}

Future<AttributeModel> getAttributes() async {
  return AttributeModel.fromJson(await handleResponse(await buildHttpResponse('petstore/api/v1/woocommerce/get-product-attribute', method: HttpMethod.GET)));
}
//endregion

//region Wishlist
Future<List<WishListModel>> getWishList() async {
  Iterable it = (await handleResponse(await buildHttpResponse('petstore/api/v1/wishlist/get-wishlist', method: HttpMethod.GET)));
  return it.map((e) => WishListModel.fromJson(e)).toList();
}

Future<void> addToWishListApi({required String proId}) async {
  Map req = {'pro_id': proId};
  return await handleResponse(await buildHttpResponse('petstore/api/v1/wishlist/add-wishlist', request: req, method: HttpMethod.POST));
}

Future<void> removeToWishListApi({required String proId}) async {
  Map req = {'pro_id': proId};
  return await handleResponse(await buildHttpResponse('petstore/api/v1/wishlist/delete-wishlist?post_id=$proId', request: req, method: HttpMethod.POST));
}
//endregion

//region Cart

Future<CartModel> getCartListApi() async {
  return CartModel.fromJson(await handleResponse(await buildHttpResponse('petstore/api/v1/cart/get-cart', method: HttpMethod.GET)));
}

Future<void> addToCartApi({required int proId, String qty = "1"}) async {
  Map req = {"pro_id": "$proId", "quantity": qty};
  return await handleResponse(await buildHttpResponse('petstore/api/v1/cart/add-cart', request: req, method: HttpMethod.POST));
}

Future<void> removeToCartApi({required int proId}) async {
  Map req = {"pro_id": '$proId'};
  return await handleResponse(await buildHttpResponse('petstore/api/v1/cart/delete-cart', request: req, method: HttpMethod.POST));
}

Future<void> updateCartProduct({required String proId, required String cartId, String qty = "1"}) async {
  Map req = {"pro_id": proId, "quantity": qty, "cart_id": cartId};
  return await handleResponse(await buildHttpResponse('petstore/api/v1/cart/update-cart', request: req, method: HttpMethod.POST));
}

Future clearCartItems() async {
  return await handleResponse(await buildHttpResponse('petstore/api/v1/cart/clear-cart', method: HttpMethod.POST));
}

Future<CustomerUpdate> updateCustomer({required Map req, int? id}) async {
  return CustomerUpdate.fromJson(await handleResponse(await petShopAPI.postAsync('/wc/v3/customers/$id', req, requireToken: true)));
}

Future<void> addCartItemList({List<CartListItemModel>? list}) async {
  Map req = {"cart_data": list};
  return await handleResponse(await buildHttpResponse('petstore/api/v1/cart/add-from-guest-cart', request: req, method: HttpMethod.POST));
}

//endregion

//region Profile
Future<MultipartRequest> getMultiPartRequest(String endPoint, {String? baseUrl}) async {
  String url = '${baseUrl ?? buildBaseUrl(endPoint).toString()}';
  log(url);
  return MultipartRequest('POST', Uri.parse(url));
}

Future sendMultiPartRequest(MultipartRequest multiPartRequest, {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  multiPartRequest.headers.addAll(buildHeaderTokens());

  await multiPartRequest.send().then((res) {
    log(res.statusCode);
    res.stream.transform(utf8.decoder).listen((value) {
      log(value);
      onSuccess?.call(jsonDecode(value));
    });
  }).catchError((error) {
    onError?.call(error.toString());
  });
}

Future updateProfileImage({File? file}) async {
  MultipartRequest multiPartRequest = await getMultiPartRequest('petstore/api/v1/customer/save-profile-image');

  if (file != null) multiPartRequest.files.add(await MultipartFile.fromPath('profile_image', file.path));

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    if (data != null) {
      appStore.setUserImage(data['pstore_profile_image']);
    }
  }, onError: (error) {
    toast(error.toString());
  });
}
//endregion

//region Order
Future createOrderApi(req) async {
  return await handleResponse(await petShopAPI.postAsync('/wc/v3/orders', req, requireToken: true));
}

Future createOrderNotes(orderId, req) async {
  return await handleResponse(await petShopAPI.postAsync('/wc/v3/orders/$orderId/notes', req, requireToken: true));
}

Future<List<OrderResponseModel>> getOrders() async {
  Iterable it = (await handleResponse(await buildHttpResponse('petstore/api/v1/woocommerce/get-customer-orders', method: HttpMethod.GET)));
  return it.map((e) => OrderResponseModel.fromJson(e)).toList();
}

Future<List<OrderTracking>> getOrdersTracking1(orderId) async {
  //return handleResponse(await petShopAPI.getAsync('/wc/wc/v3/orders/$orderId/notes'));
  Iterable it = (await handleResponse(await petShopAPI.getAsync('/wc/v3/orders/$orderId/notes')));
  return it.map((e) => OrderTracking.fromJson(e)).toList();
}

Future cancelOrder(orderId, request) async {
  return handleResponse(await petShopAPI.postAsync('/wc/v3/orders/$orderId', request));
}

Future<void> updateAddress({required Map req, int? id}) async {
  return await handleResponse(await petShopAPI.postAsync('/wc/v3/customers/$id', req, requireToken: true));
}

Future getCountries() async {
  //Iterable it = (await handleResponse(await petShopAPI.getAsync('/wc/v3/data/countries')));
  // return it.map((e) => Country.fromJson(e)).toList();
  return handleResponse(await petShopAPI.getAsync('/wc/v3/data/countries', requireToken: false));
}

//endregion
