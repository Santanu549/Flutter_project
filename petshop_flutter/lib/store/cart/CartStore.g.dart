// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on _CartStore, Store {
  final _$cartListAtom = Atom(name: '_CartStore.cartList');

  @override
  ObservableList<CartData> get cartList {
    _$cartListAtom.reportRead();
    return super.cartList;
  }

  @override
  set cartList(ObservableList<CartData> value) {
    _$cartListAtom.reportWrite(value, super.cartList, () {
      super.cartList = value;
    });
  }

  final _$cartTotalAmountAtom = Atom(name: '_CartStore.cartTotalAmount');

  @override
  double get cartTotalAmount {
    _$cartTotalAmountAtom.reportRead();
    return super.cartTotalAmount;
  }

  @override
  set cartTotalAmount(double value) {
    _$cartTotalAmountAtom.reportWrite(value, super.cartTotalAmount, () {
      super.cartTotalAmount = value;
    });
  }

  final _$cartTotalPayableAmountAtom = Atom(name: '_CartStore.cartTotalPayableAmount');

  @override
  double get cartTotalPayableAmount {
    _$cartTotalPayableAmountAtom.reportRead();
    return super.cartTotalPayableAmount;
  }

  @override
  set cartTotalPayableAmount(double value) {
    _$cartTotalPayableAmountAtom.reportWrite(value, super.cartTotalPayableAmount, () {
      super.cartTotalPayableAmount = value;
    });
  }

  final _$cartSavedAmountAtom = Atom(name: '_CartStore.cartSavedAmount');

  @override
  double get cartSavedAmount {
    _$cartSavedAmountAtom.reportRead();
    return super.cartSavedAmount;
  }

  @override
  set cartSavedAmount(double value) {
    _$cartSavedAmountAtom.reportWrite(value, super.cartSavedAmount, () {
      super.cartSavedAmount = value;
    });
  }

  final _$addToCartAsyncAction = AsyncAction('_CartStore.addToCart');

  @override
  Future<void> addToCart(CartData data) {
    return _$addToCartAsyncAction.run(() => super.addToCart(data));
  }

  final _$updateCartItemAsyncAction = AsyncAction('_CartStore.updateCartItem');

  @override
  Future<void> updateCartItem(CartData item) {
    return _$updateCartItemAsyncAction.run(() => super.updateCartItem(item));
  }

  final _$storeCartDataAsyncAction = AsyncAction('_CartStore.storeCartData');

  @override
  Future<void> storeCartData() {
    return _$storeCartDataAsyncAction.run(() => super.storeCartData());
  }

  final _$clearCartAsyncAction = AsyncAction('_CartStore.clearCart');

  @override
  Future<void> clearCart() {
    return _$clearCartAsyncAction.run(() => super.clearCart());
  }

  final _$_CartStoreActionController = ActionController(name: '_CartStore');

  @override
  void addAllCartItem(List<CartData> productList) {
    final _$actionInfo = _$_CartStoreActionController.startAction(name: '_CartStore.addAllCartItem');
    try {
      return super.addAllCartItem(productList);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotals() {
    final _$actionInfo = _$_CartStoreActionController.startAction(name: '_CartStore.calculateTotals');
    try {
      return super.calculateTotals();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCartList() {
    final _$actionInfo = _$_CartStoreActionController.startAction(name: '_CartStore.getCartList');
    try {
      return super.getCartList();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartList: ${cartList},
cartTotalAmount: ${cartTotalAmount},
cartTotalPayableAmount: ${cartTotalPayableAmount},
cartSavedAmount: ${cartSavedAmount}
    ''';
  }
}
