import 'package:mobx/mobx.dart';
import 'package:pet_shop_flutter/model/dashboard/CategoryModel.dart';

part 'CategoryStore.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  @observable
  ObservableList<CategoryModel> categoryList = ObservableList<CategoryModel>();

  @action
  void addCategoryList(List<CategoryModel> dataList) {
    categoryList.addAll(dataList);
  }
}
