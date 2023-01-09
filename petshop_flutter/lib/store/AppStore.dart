import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/local/AppLocalizations.dart';
import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';
import 'package:pet_shop_flutter/screens/carts/CartFragment.dart';
import 'package:pet_shop_flutter/screens/category/CategoryFragment.dart';
import 'package:pet_shop_flutter/screens/home/HomeFragment.dart';
import 'package:pet_shop_flutter/screens/profile/ProfileFragment.dart';
import 'package:pet_shop_flutter/screens/wishlist/WishlistFragment.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

import '../main.dart';

part 'AppStore.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  //region App
  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @observable
  bool isDarkMode = false;

  @observable
  String token = '';

  @observable
  String userName = '';

  @observable
  String userEmail = '';

  @observable
  String userPassword = '';

  @observable
  String firstName = '';

  @observable
  String lastName = '';

  @observable
  int userId = 0;

  @observable
  String userImage = '';

  @observable
  ShippingModel shippingModel = ShippingModel();

  @observable
  bool isAddressSame = false;

  @observable
  ShippingModel? billingAddress;

  @observable
  ShippingModel? shippingAddress;

  @observable
  String selectedLanguageCode = defaultLanguage;

  @action
  Future<void> setLanguage(String val) async {
    selectedLanguageCode = val;
    selectedLanguageDataModel = getSelectedLanguageModel();

    await setValue(SELECTED_LANGUAGE_CODE, selectedLanguageCode);

    language = await AppLocalizations().load(Locale(selectedLanguageCode));

    errorInternetNotAvailable = language!.noInternet;
  }

  @action
  Future<void> setUserImage(String val, {bool isInitialization = false}) async {
    userImage = val;
    if (!isInitialization) await setValue(USER_PHOTO_URL, val);
  }

  @action
  Future<void> setBillingAddress(ShippingModel? model, {bool isInitialization = false}) async {
    billingAddress = model;

    if (model != null) {
      if (!isInitialization) await setValue(BILLING_ADDRESS, jsonEncode(model));
    } else {
      await setValue(BILLING_ADDRESS, '');
    }
  }

  @action
  Future<void> setShippingAddress(ShippingModel? model, {bool isInitialization = false}) async {
    shippingAddress = model;

    if (model != null) {
      shippingModel = model;

      if (!isInitialization) await setValue(SHIPPING_ADDRESS, jsonEncode(model));
    } else {
      await setValue(SHIPPING_ADDRESS, '');
    }
  }

  @action
  void setAddress(bool val) {
    isAddressSame = val;
  }

  @action
  Future<void> setUserID(int val, {bool isInitialization = false}) async {
    userId = val;
    if (!isInitialization) await setValue(USER_ID, val);
  }

  @action
  Future<void> setLogin(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGGED_IN, val);
  }

  @action
  Future<void> setFirstName(String val, {bool isInitialization = false}) async {
    firstName = val;
    if (!isInitialization) await setValue(FIRST_NAME, val);
  }

  @action
  Future<void> setLastName(String val, {bool isInitialization = false}) async {
    lastName = val;
    if (!isInitialization) await setValue(LAST_NAME, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitialization = false}) async {
    userEmail = val;
    if (!isInitialization) await setValue(USER_EMAIL, val);
  }

  @action
  Future<void> setUserName(String val, {bool isInitialization = false}) async {
    userName = val;
    if (!isInitialization) await setValue(USER_NAME, val);
  }

  @action
  Future<void> setUserPassword(String val, {bool isInitialization = false}) async {
    userPassword = val;
    if (!isInitialization) await setValue(USER_PASSWORD, val);
  }

  @action
  Future<void> setToken(String val, {bool isInitialization = false}) async {
    token = val;
    if (!isInitialization) await setValue(API_TOKEN, val);
  }

  @action
  void setLoading(bool aIsLoading) {
    isLoading = aIsLoading;
  }

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = scaffoldSecondaryDark;
      appButtonBackgroundColorGlobal = primaryColor;
      defaultAppButtonTextColorGlobal = textPrimaryColor;

      shadowColorGlobal = Colors.white12;
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = primaryColor;
      defaultAppButtonTextColorGlobal = Colors.white;

      shadowColorGlobal = Colors.black12;
    }

    setStatusBarColor(appStore.isDarkMode ? scaffoldSecondaryDark : white);
  }

//endregion

  //region Network
  @observable
  ConnectivityResult connectivityResult = ConnectivityResult.none;

  @computed
  bool get isNetworkConnected => connectivityResult != ConnectivityResult.none;

  @action
  void setConnectionState(ConnectivityResult val) {
    connectivityResult = val;
  }

  //endregion

  //region Dashboard
  @observable
  int index = 0;

  @observable
  List<Widget> dashboardScreeList = [
    HomeFragment(),
    CategoryFragment(),
    CartFragment(),
    WishlistFragment(),
    ProfileFragment(),
  ];

  @action
  void setBottomNavigationIndex(int val) {
    index = val;
  }
//endregion
}
