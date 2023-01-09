import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pet_shop_flutter/AppTheme.dart';
import 'package:pet_shop_flutter/local/AppLocalizations.dart';
import 'package:pet_shop_flutter/local/BaseLanguage.dart';
import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';
import 'package:pet_shop_flutter/model/cart/CartModel.dart';
import 'package:pet_shop_flutter/model/wishlist/WishListModel.dart';
import 'package:pet_shop_flutter/screens/SplashScreen.dart';
import 'package:pet_shop_flutter/store/AppStore.dart';
import 'package:pet_shop_flutter/store/cart/CartStore.dart';
import 'package:pet_shop_flutter/store/wishList/WishListStore.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

AppStore appStore = AppStore();
CartStore cartStore = CartStore();
WishListStore wishListStore = WishListStore();
BaseLanguage? language;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: languageList());
  await appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage));

  defaultRadius = 20;
  defaultAppButtonShapeBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius));
  appButtonBackgroundColorGlobal = primaryColor;

  //region Init OneSignal
  if (isMobile) {
    OneSignal.shared.setAppId(mOneSignalAppId);
    if (isIos) {
      OneSignal.shared.consentGranted(true);
      OneSignal.shared.promptUserForPushNotificationPermission();
    }
  }
  //endregion

  //region Init AppStore Values
  appStore.setLogin(getBoolAsync(IS_LOGGED_IN), isInitializing: true);
  appStore.setUserName(getStringAsync(USER_NAME), isInitialization: true);
  appStore.setToken(getStringAsync(API_TOKEN), isInitialization: true);
  appStore.setUserID(getIntAsync(USER_ID), isInitialization: true);
  appStore.setUserEmail(getStringAsync(USER_EMAIL), isInitialization: true);
  appStore.setFirstName(getStringAsync(FIRST_NAME), isInitialization: true);
  appStore.setLastName(getStringAsync(LAST_NAME), isInitialization: true);
  appStore.setUserPassword(getStringAsync(USER_PASSWORD), isInitialization: true);
  appStore.setUserImage(getStringAsync(USER_PHOTO_URL), isInitialization: true);

  String billingAddressString = getStringAsync(BILLING_ADDRESS);
  if (billingAddressString.isNotEmpty) {
    appStore.setBillingAddress(ShippingModel.fromJson(jsonDecode(billingAddressString)), isInitialization: true);
  }
  String shippingAddressString = getStringAsync(SHIPPING_ADDRESS);
  if (shippingAddressString.isNotEmpty) {
    appStore.setShippingAddress(ShippingModel.fromJson(jsonDecode(shippingAddressString)), isInitialization: true);
  }

  String cartString = getStringAsync(CART_ITEM_LIST);
  if (cartString.isNotEmpty) {
    cartStore.addAllCartItem(jsonDecode(cartString).map<CartData>((e) => CartData.fromJson(e)).toList());
    cartStore.calculateTotals();
  }
  String wishListString = getStringAsync(WISHLIST_ITEM_LIST);
  if (wishListString.isNotEmpty) {
    wishListStore.addAllCartItem(jsonDecode(wishListString).map<WishListModel>((e) => WishListModel.fromJson(e)).toList());
  }
  //endregion

  double themeModeIndex = getDoubleAsync(THEME_MODE_INDEX);
  if (themeModeIndex == ThemeModeLight) {
    appStore.setDarkMode(false);
  } else if (themeModeIndex == ThemeModeDark) {
    appStore.setDarkMode(true);
  }

  setOrientationPortrait();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((event) {
      appStore.setConnectionState(event);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached || state == AppLifecycleState.inactive) {
      _connectivitySubscription.pause();
    } else if (state == AppLifecycleState.resumed) {
      _connectivitySubscription.resume();

      Connectivity().checkConnectivity().then((value) {
        appStore.setConnectionState(value);
      }).catchError((e) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        navigatorKey: navigatorKey,
        themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: SplashScreen(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [AppLocalizations(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguageCode),
      ),
    );
  }
}
