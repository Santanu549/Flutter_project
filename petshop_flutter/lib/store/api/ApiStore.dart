import 'package:mobx/mobx.dart';
import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';

part 'ApiStore.g.dart';

class ApiStore = _ApiStore with _$ApiStore;

abstract class _ApiStore with Store {
  //region Product List
  @observable
  ObservableList<ProductDetailModel> productList = ObservableList.of([]);

  @action
  void addProductInList(ProductDetailModel data) {
    productList.add(data);
  }

  @action
  void addAllProductInList(List<ProductDetailModel> list) {
    productList.addAll(list);
  }

  @action
  void clearProductList() {
    productList.clear();
  }

  //endregion

  //region Pagination Count
  @observable
  int page = 1;

  @action
  void increasePageCount() {
    page++;
  }

//endregion

  //region Load More Item
  @observable
  bool isLoadMore = true;

  @action
  void setLoadMore(bool aIsLoadMore) {
    isLoadMore = aIsLoadMore;
  }

//endregion
}
