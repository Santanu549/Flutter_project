import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/ProductCardWidget.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';
import 'package:pet_shop_flutter/screens/ProductDetailScreen.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppImages.dart';

class ProductSectionWidget extends StatelessWidget {
  final String? sectionTitle;
  final List<ProductDetailModel>? productList;
  final VoidCallback? viewAll;

  ProductSectionWidget({this.sectionTitle, this.productList, this.viewAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionHeadingText(title: sectionTitle.validate()),
        Wrap(
          runSpacing: 8,
          spacing: 8,
          children: productList!.take(4).map((e) {
            return ProductCardWidget(proDetail: e).onTap(() {
              ProductDetailScreen(productID: e.id).launch(context);
            });
          }).toList(),
        ),
        8.height,
        SizedBox(
          width: context.width(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language!.viewAll, style: secondaryTextStyle(size: 20)).paddingAll(12).center(),
              Row(
                children: [
                  Divider(indent: 4, endIndent: 16, thickness: 1).expand(),
                  commonCacheImage(petLogo, width: 30, height: 30),
                  Divider(indent: 16, endIndent: 4, thickness: 1).expand(),
                ],
              ),
            ],
          ).paddingOnly(left: 8, right: 8),
        ).onTap(() {
          viewAll!.call();
        })
      ],
    );
  }
}
