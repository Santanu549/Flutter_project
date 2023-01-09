// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  Computed<bool>? _$isNetworkConnectedComputed;

  @override
  bool get isNetworkConnected => (_$isNetworkConnectedComputed ??= Computed<bool>(() => super.isNetworkConnected, name: '_AppStore.isNetworkConnected')).value;

  final _$isLoadingAtom = Atom(name: '_AppStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isLoggedInAtom = Atom(name: '_AppStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$isDarkModeAtom = Atom(name: '_AppStore.isDarkMode');

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  final _$tokenAtom = Atom(name: '_AppStore.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$userNameAtom = Atom(name: '_AppStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$userEmailAtom = Atom(name: '_AppStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$userPasswordAtom = Atom(name: '_AppStore.userPassword');

  @override
  String get userPassword {
    _$userPasswordAtom.reportRead();
    return super.userPassword;
  }

  @override
  set userPassword(String value) {
    _$userPasswordAtom.reportWrite(value, super.userPassword, () {
      super.userPassword = value;
    });
  }

  final _$firstNameAtom = Atom(name: '_AppStore.firstName');

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  final _$lastNameAtom = Atom(name: '_AppStore.lastName');

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  final _$userIdAtom = Atom(name: '_AppStore.userId');

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$userImageAtom = Atom(name: '_AppStore.userImage');

  @override
  String get userImage {
    _$userImageAtom.reportRead();
    return super.userImage;
  }

  @override
  set userImage(String value) {
    _$userImageAtom.reportWrite(value, super.userImage, () {
      super.userImage = value;
    });
  }

  final _$shippingModelAtom = Atom(name: '_AppStore.shippingModel');

  @override
  ShippingModel get shippingModel {
    _$shippingModelAtom.reportRead();
    return super.shippingModel;
  }

  @override
  set shippingModel(ShippingModel value) {
    _$shippingModelAtom.reportWrite(value, super.shippingModel, () {
      super.shippingModel = value;
    });
  }

  final _$isAddressSameAtom = Atom(name: '_AppStore.isAddressSame');

  @override
  bool get isAddressSame {
    _$isAddressSameAtom.reportRead();
    return super.isAddressSame;
  }

  @override
  set isAddressSame(bool value) {
    _$isAddressSameAtom.reportWrite(value, super.isAddressSame, () {
      super.isAddressSame = value;
    });
  }

  final _$billingAddressAtom = Atom(name: '_AppStore.billingAddress');

  @override
  ShippingModel? get billingAddress {
    _$billingAddressAtom.reportRead();
    return super.billingAddress;
  }

  @override
  set billingAddress(ShippingModel? value) {
    _$billingAddressAtom.reportWrite(value, super.billingAddress, () {
      super.billingAddress = value;
    });
  }

  final _$shippingAddressAtom = Atom(name: '_AppStore.shippingAddress');

  @override
  ShippingModel? get shippingAddress {
    _$shippingAddressAtom.reportRead();
    return super.shippingAddress;
  }

  @override
  set shippingAddress(ShippingModel? value) {
    _$shippingAddressAtom.reportWrite(value, super.shippingAddress, () {
      super.shippingAddress = value;
    });
  }

  final _$selectedLanguageCodeAtom = Atom(name: '_AppStore.selectedLanguageCode');

  @override
  String get selectedLanguageCode {
    _$selectedLanguageCodeAtom.reportRead();
    return super.selectedLanguageCode;
  }

  @override
  set selectedLanguageCode(String value) {
    _$selectedLanguageCodeAtom.reportWrite(value, super.selectedLanguageCode, () {
      super.selectedLanguageCode = value;
    });
  }

  final _$connectivityResultAtom = Atom(name: '_AppStore.connectivityResult');

  @override
  ConnectivityResult get connectivityResult {
    _$connectivityResultAtom.reportRead();
    return super.connectivityResult;
  }

  @override
  set connectivityResult(ConnectivityResult value) {
    _$connectivityResultAtom.reportWrite(value, super.connectivityResult, () {
      super.connectivityResult = value;
    });
  }

  final _$indexAtom = Atom(name: '_AppStore.index');

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  final _$dashboardScreeListAtom = Atom(name: '_AppStore.dashboardScreeList');

  @override
  List<Widget> get dashboardScreeList {
    _$dashboardScreeListAtom.reportRead();
    return super.dashboardScreeList;
  }

  @override
  set dashboardScreeList(List<Widget> value) {
    _$dashboardScreeListAtom.reportWrite(value, super.dashboardScreeList, () {
      super.dashboardScreeList = value;
    });
  }

  final _$setLanguageAsyncAction = AsyncAction('_AppStore.setLanguage');

  @override
  Future<void> setLanguage(String val) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(val));
  }

  final _$setUserImageAsyncAction = AsyncAction('_AppStore.setUserImage');

  @override
  Future<void> setUserImage(String val, {bool isInitialization = false}) {
    return _$setUserImageAsyncAction.run(() => super.setUserImage(val, isInitialization: isInitialization));
  }

  final _$setBillingAddressAsyncAction = AsyncAction('_AppStore.setBillingAddress');

  @override
  Future<void> setBillingAddress(ShippingModel? model, {bool isInitialization = false}) {
    return _$setBillingAddressAsyncAction.run(() => super.setBillingAddress(model, isInitialization: isInitialization));
  }

  final _$setShippingAddressAsyncAction = AsyncAction('_AppStore.setShippingAddress');

  @override
  Future<void> setShippingAddress(ShippingModel? model, {bool isInitialization = false}) {
    return _$setShippingAddressAsyncAction.run(() => super.setShippingAddress(model, isInitialization: isInitialization));
  }

  final _$setUserIDAsyncAction = AsyncAction('_AppStore.setUserID');

  @override
  Future<void> setUserID(int val, {bool isInitialization = false}) {
    return _$setUserIDAsyncAction.run(() => super.setUserID(val, isInitialization: isInitialization));
  }

  final _$setLoginAsyncAction = AsyncAction('_AppStore.setLogin');

  @override
  Future<void> setLogin(bool val, {bool isInitializing = false}) {
    return _$setLoginAsyncAction.run(() => super.setLogin(val, isInitializing: isInitializing));
  }

  final _$setFirstNameAsyncAction = AsyncAction('_AppStore.setFirstName');

  @override
  Future<void> setFirstName(String val, {bool isInitialization = false}) {
    return _$setFirstNameAsyncAction.run(() => super.setFirstName(val, isInitialization: isInitialization));
  }

  final _$setLastNameAsyncAction = AsyncAction('_AppStore.setLastName');

  @override
  Future<void> setLastName(String val, {bool isInitialization = false}) {
    return _$setLastNameAsyncAction.run(() => super.setLastName(val, isInitialization: isInitialization));
  }

  final _$setUserEmailAsyncAction = AsyncAction('_AppStore.setUserEmail');

  @override
  Future<void> setUserEmail(String val, {bool isInitialization = false}) {
    return _$setUserEmailAsyncAction.run(() => super.setUserEmail(val, isInitialization: isInitialization));
  }

  final _$setUserNameAsyncAction = AsyncAction('_AppStore.setUserName');

  @override
  Future<void> setUserName(String val, {bool isInitialization = false}) {
    return _$setUserNameAsyncAction.run(() => super.setUserName(val, isInitialization: isInitialization));
  }

  final _$setUserPasswordAsyncAction = AsyncAction('_AppStore.setUserPassword');

  @override
  Future<void> setUserPassword(String val, {bool isInitialization = false}) {
    return _$setUserPasswordAsyncAction.run(() => super.setUserPassword(val, isInitialization: isInitialization));
  }

  final _$setTokenAsyncAction = AsyncAction('_AppStore.setToken');

  @override
  Future<void> setToken(String val, {bool isInitialization = false}) {
    return _$setTokenAsyncAction.run(() => super.setToken(val, isInitialization: isInitialization));
  }

  final _$setDarkModeAsyncAction = AsyncAction('_AppStore.setDarkMode');

  @override
  Future<void> setDarkMode(bool aIsDarkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(aIsDarkMode));
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void setAddress(bool val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(name: '_AppStore.setAddress');
    try {
      return super.setAddress(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool aIsLoading) {
    final _$actionInfo = _$_AppStoreActionController.startAction(name: '_AppStore.setLoading');
    try {
      return super.setLoading(aIsLoading);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnectionState(ConnectivityResult val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(name: '_AppStore.setConnectionState');
    try {
      return super.setConnectionState(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBottomNavigationIndex(int val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(name: '_AppStore.setBottomNavigationIndex');
    try {
      return super.setBottomNavigationIndex(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isLoggedIn: ${isLoggedIn},
isDarkMode: ${isDarkMode},
token: ${token},
userName: ${userName},
userEmail: ${userEmail},
userPassword: ${userPassword},
firstName: ${firstName},
lastName: ${lastName},
userId: ${userId},
userImage: ${userImage},
shippingModel: ${shippingModel},
isAddressSame: ${isAddressSame},
billingAddress: ${billingAddress},
shippingAddress: ${shippingAddress},
selectedLanguageCode: ${selectedLanguageCode},
connectivityResult: ${connectivityResult},
index: ${index},
dashboardScreeList: ${dashboardScreeList},
isNetworkConnected: ${isNetworkConnected}
    ''';
  }
}
