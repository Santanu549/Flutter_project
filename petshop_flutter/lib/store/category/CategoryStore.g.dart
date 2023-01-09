// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryStore on _CategoryStore, Store {
  final _$categoryListAtom = Atom(name: '_CategoryStore.categoryList');

  @override
  ObservableList<CategoryModel> get categoryList {
    _$categoryListAtom.reportRead();
    return super.categoryList;
  }

  @override
  set categoryList(ObservableList<CategoryModel> value) {
    _$categoryListAtom.reportWrite(value, super.categoryList, () {
      super.categoryList = value;
    });
  }

  final _$_CategoryStoreActionController = ActionController(name: '_CategoryStore');

  @override
  void addCategoryList(List<CategoryModel> dataList) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction(name: '_CategoryStore.addCategoryList');
    try {
      return super.addCategoryList(dataList);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoryList: ${categoryList}
    ''';
  }
}
