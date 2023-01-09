// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ApiStore on _ApiStore, Store {
  final _$productListAtom = Atom(name: '_ApiStore.productList');

  @override
  ObservableList<ProductDetailModel> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(ObservableList<ProductDetailModel> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  final _$pageAtom = Atom(name: '_ApiStore.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$isLoadMoreAtom = Atom(name: '_ApiStore.isLoadMore');

  @override
  bool get isLoadMore {
    _$isLoadMoreAtom.reportRead();
    return super.isLoadMore;
  }

  @override
  set isLoadMore(bool value) {
    _$isLoadMoreAtom.reportWrite(value, super.isLoadMore, () {
      super.isLoadMore = value;
    });
  }

  final _$_ApiStoreActionController = ActionController(name: '_ApiStore');

  @override
  void addProductInList(ProductDetailModel data) {
    final _$actionInfo = _$_ApiStoreActionController.startAction(name: '_ApiStore.addProductInList');
    try {
      return super.addProductInList(data);
    } finally {
      _$_ApiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAllProductInList(List<ProductDetailModel> list) {
    final _$actionInfo = _$_ApiStoreActionController.startAction(name: '_ApiStore.addAllProductInList');
    try {
      return super.addAllProductInList(list);
    } finally {
      _$_ApiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearProductList() {
    final _$actionInfo = _$_ApiStoreActionController.startAction(name: '_ApiStore.clearProductList');
    try {
      return super.clearProductList();
    } finally {
      _$_ApiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increasePageCount() {
    final _$actionInfo = _$_ApiStoreActionController.startAction(name: '_ApiStore.increasePageCount');
    try {
      return super.increasePageCount();
    } finally {
      _$_ApiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoadMore(bool aIsLoadMore) {
    final _$actionInfo = _$_ApiStoreActionController.startAction(name: '_ApiStore.setLoadMore');
    try {
      return super.setLoadMore(aIsLoadMore);
    } finally {
      _$_ApiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productList: ${productList},
page: ${page},
isLoadMore: ${isLoadMore}
    ''';
  }
}
