import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/cart/CartModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

part 'CartStore.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  ObservableList<CartData> cartList = ObservableList.of([]);

  @observable
  double cartTotalAmount = 0.0;

  @observable
  double cartTotalPayableAmount = 0.0;

  @observable
  double cartSavedAmount = 0.0;

  @action
  Future<void> addToCart(CartData data) async {
    if (cartList.any((element) => element.pro_id == data.pro_id)) {
      cartList.remove(data);

      if (appStore.isLoading) {
        await removeToCartApi(proId: data.pro_id!).then((value) {
          getCartList();
        }).catchError((error) {
          log(error.toString());
        });
      }
      snack('Item remove from cart');

      calculateTotals();
    } else {
      cartList.add(data);

      if (appStore.isLoading) {
        await addToCartApi(proId: data.pro_id!).then((value) {
          getCartList();
        }).catchError((error) {
          log(error.toString());
        });
      }
      snack('Item added to cart');

      calculateTotals();
    }
  }

  @action
  Future<void> updateCartItem(CartData item) async {
    if (item.quantity.validate().toInt() > 1) {
      int itemIndex = cartList.indexOf(item);
      cartList[itemIndex] = item;

      calculateTotals();

      if (appStore.isLoading) {
        updateCartProduct(proId: item.pro_id.toString(), cartId: item.cart_id.validate().toString(), qty: item.quantity.toString()).then((value) {
          //
        }).catchError((e) {
          snack(e.toString());
        });
      }
    }
  }

  @action
  void addAllCartItem(List<CartData> productList) {
    cartList.addAll(productList);
  }

  bool isItemInCart(int id) {
    return cartList.any((element) => element.pro_id == id.validate());
  }

  @action
  void calculateTotals() {
    cartTotalAmount = cartList.sumByDouble((e) => e.regular_price.toDouble() * e.quantity.validate(value: '1').toDouble());
    cartTotalPayableAmount = cartTotalAmount - cartList.sumByDouble((e) => e.discountPrice * e.quantity.validate(value: '1').toDouble());

    cartSavedAmount = cartTotalAmount - cartTotalPayableAmount;

    storeCartData();
  }

  @action
  Future<void> storeCartData() async {
    if (cartList.isNotEmpty) {
      await setValue(CART_ITEM_LIST, jsonEncode(cartList));
    } else {
      await setValue(CART_ITEM_LIST, '');
    }
  }

  @action
  void getCartList() {
    getCartListApi().then((value) {
      cartList = ObservableList.of(value.data!);
    }).catchError((error) {
      log(error.toString());
    });
  }

  @action
  Future<void> clearCart() async {
    cartList.clear();
    storeCartData();
  }
}
