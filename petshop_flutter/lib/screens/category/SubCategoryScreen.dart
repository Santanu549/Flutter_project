import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/model/dashboard/CategoryModel.dart';
import 'package:pet_shop_flutter/screens/category/components/CategoryListWidget.dart';
import 'package:pet_shop_flutter/screens/productByCategory/ProductListByCategoryScreen.dart';
import 'package:pet_shop_flutter/store/category/CategoryStore.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

import '../../main.dart';

class SubCategoryScreen extends StatefulWidget {
  final List<CategoryModel>? categoryList;
  final String? subCatTitle;

  SubCategoryScreen({this.categoryList, this.subCatTitle});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CategoryStore categoryStore = CategoryStore();
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBarWidget(widget.subCatTitle.validate(), color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
      body: Observer(
        builder: (_) => SafeArea(
          child: SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                CategoryListWidget(
                  categoryList: widget.categoryList,
                  onCatTap: (CategoryModel categoryModel) {
                    ProductListByCategoryScreen(
                      req: {
                        "text": "",
                        "item_type": "",
                        "attribute": [],
                        "price": [],
                        "category": categoryModel.cat_ID,
                        "product_per_page": postPerPage,
                      },
                    ).launch(context);
                  },
                ).paddingOnly(left: 8, top: 16, right: 8, bottom: 16),
                Loader().visible(appStore.isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
