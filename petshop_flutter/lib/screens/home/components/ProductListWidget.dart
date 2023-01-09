import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/dashboard/DashboardResponse.dart';
import 'package:pet_shop_flutter/screens/home/components/ProductSectionWidget.dart';
import 'package:pet_shop_flutter/screens/productByCategory/ProductListByCategoryScreen.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class ProductListWidget extends StatefulWidget {
  static String tag = '/ProductListWidget';
  final DashboardResponse? dashboardResponse;
  final List<SaleBanner>? saleBanner;

  ProductListWidget({this.dashboardResponse, this.saleBanner});

  @override
  ProductListWidgetState createState() => ProductListWidgetState();
}

class ProductListWidgetState extends State<ProductListWidget> {
  int banner = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Map<String, dynamic> makeRequest(String sliderTitle) {
    return {
      "text": "",
      "item_type": "",
      "attribute": [],
      "price": [],
      "product_per_page": postPerPage,
      sliderTitle: sliderTitle,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.cardColor,
      child: Column(
        children: [
          Column(
            children: [
              //region Section Wise List
              ProductSectionWidget(
                sectionTitle: language!.bestSellingProduct,
                productList: widget.dashboardResponse!.best_selling_product!,
                viewAll: () {
                  ProductListByCategoryScreen(
                    req: makeRequest("best_selling_product"),
                  ).launch(context);
                },
              ).visible(widget.dashboardResponse!.best_selling_product!.isNotEmpty),
              4.height,
              if (widget.saleBanner.validate().length >= 1)
                SizedBox(
                  width: context.width(),
                  child: commonCacheImage(widget.saleBanner![0].image),
                ).paddingSymmetric(vertical: 8),
              ProductSectionWidget(
                sectionTitle: language!.saleProduct,
                productList: widget.dashboardResponse!.sale_product.validate(),
                viewAll: () {
                  ProductListByCategoryScreen(
                    req: makeRequest("sale_product"),
                  ).launch(context);
                },
              ).visible(widget.dashboardResponse!.sale_product!.isNotEmpty),
              if (widget.saleBanner!.length >= 1)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.saleBanner!.length - 1,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: context.width(),
                      child: commonCacheImage(widget.saleBanner![index + 1].image),
                    ).paddingSymmetric(vertical: 8);
                  },
                ),
              ProductSectionWidget(
                sectionTitle: language!.newest,
                productList: widget.dashboardResponse!.newest.validate(),
                viewAll: () {
                  ProductListByCategoryScreen(
                    req: makeRequest("newest"),
                  ).launch(context);
                },
              ).visible(widget.dashboardResponse!.sale_product!.isNotEmpty),
              //endregion
            ],
          ),
        ],
      ),
    );
  }
}
