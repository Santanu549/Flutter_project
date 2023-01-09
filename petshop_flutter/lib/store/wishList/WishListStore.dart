import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/wishlist/WishListModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

part 'WishListStore.g.dart';

class WishListStore = _WishListStore with _$WishListStore;

abstract class _WishListStore with Store {
  @observable
  ObservableList<WishListModel> wishList = ObservableList.of([]);

  @action
  Future<void> addToWishList(WishListModel data) async {
    if (wishList.any((element) => element.pro_id == data.pro_id)) {
      wishList.remove(wishList.firstWhere((element) => element.pro_id == data.pro_id));

      if (appStore.isLoading) {
        await removeToWishListApi(proId: data.pro_id.toString()).then((value) {
          //
        }).catchError((e) {
          log(e.toString());
        });
      }
    } else {
      wishList.add(data);

      if (appStore.isLoading) {
        await addToWishListApi(proId: data.pro_id.toString()).then((value) {
          //
        }).catchError((e) {
          log(e.toString());
        });
      }
    }
    storeWishlistData();
  }

  bool isItemInWishlist(int id) {
    return wishList.any((element) => element.pro_id == id.validate());
  }

  @action
  Future<void> storeWishlistData() async {
    if (wishList.isNotEmpty) {
      await setValue(WISHLIST_ITEM_LIST, jsonEncode(wishList));
    } else {
      await setValue(WISHLIST_ITEM_LIST, '');
    }
  }

  @action
  void addAllCartItem(List<WishListModel> productList) {
    wishList.addAll(productList);
  }

  @action
  void getWishlistItem() {
    getWishList().then((value) {
      wishList = ObservableList.of(value);
    }).catchError((e) {
      log(e.toString());
    });
  }

  @action
  Future<void> clearWishlist() async {
    wishList.clear();
    storeWishlistData();
  }
}
