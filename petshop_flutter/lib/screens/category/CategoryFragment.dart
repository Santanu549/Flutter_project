import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppBarWidget.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/dashboard/CategoryModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/category/SubCategoryScreen.dart';
import 'package:pet_shop_flutter/screens/category/components/CategoryListWidget.dart';
import 'package:pet_shop_flutter/screens/productByCategory/ProductListByCategoryScreen.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class CategoryFragment extends StatefulWidget {
  static String tag = '/CategoryFragment';

  @override
  CategoryFragmentState createState() => CategoryFragmentState();
}

class CategoryFragmentState extends State<CategoryFragment> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    LiveStream().on(streamRefresh, (v) {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBarWidget(title: headingTextWidget(language!.category), scrollController: _scrollController),
        SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(left: 8, top: 60, right: 8, bottom: 16),
          child: FutureBuilder<List<CategoryModel>>(
            future: getAppCategories(),
            builder: (context, snap) {
              if (snap.hasData) {
                return CategoryListWidget(
                  categoryList: snap.data,
                  onCatTap: (CategoryModel cat) {
                    appStore.setLoading(true);
                    getAppCategories(catId: cat.cat_ID.validate()).then((value) {
                      appStore.setLoading(false);

                      if (value.isNotEmpty) {
                        SubCategoryScreen(categoryList: value, subCatTitle: cat.cat_name).launch(context);
                      } else {
                        ProductListByCategoryScreen(
                          req: {
                            "text": "",
                            "item_type": "",
                            "attribute": [],
                            "price": [],
                            "category": cat.cat_ID,
                            "product_per_page": postPerPage,
                          },
                        ).launch(context);
                      }
                    }).catchError((e) {
                      appStore.setLoading(false);

                      snack(e.toString());
                    });
                  },
                );
              }
              return snapWidgetHelper(snap);
            },
          ),
        ),
        Observer(
          builder: (_) => Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Loader().visible(appStore.isLoading),
          ),
        ),
      ],
    );
  }
}
