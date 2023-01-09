import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/discoutTag.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';
import 'package:pet_shop_flutter/screens/productByCategory/components/PriceWidget.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductDetailModel? proDetail;

  ProductCardWidget({this.proDetail});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Stack(
          children: [
            Container(
              width: (context.width() / 2) - 12,
              decoration: BoxDecoration(
                color: context.cardColor,
                border: Border.all(color: Colors.grey.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  commonCacheImage(
                    proDetail!.images!.first.src,
                    width: context.width(),
                    height: 200,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRectOnly(topRight: defaultRadius.toInt(), topLeft: defaultRadius.toInt()),
                  8.height,
                  Text(proDetail!.name.validate(), style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis).paddingOnly(left: 12, right: 8),
                  4.height,
                  Text(
                    parseHtmlString(proDetail!.short_description.validate()),
                    style: secondaryTextStyle(size: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 12, right: 8),
                  4.height,
                  PriceWidget(
                    salePrice: proDetail!.sale_price,
                    regularPrice: proDetail!.regular_price,
                  ).paddingOnly(left: 12, right: 8, bottom: 8),
                ],
              ),
            ),
            if (proDetail!.sale_price!.isNotEmpty)
              Positioned(
                left: 0,
                top: 20,
                child: DiscountTag(
                  discount: discountText(proDetail!.regular_price!, proDetail!.sale_price!),
                ),
              ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 6),
                decoration: BoxDecoration(
                  color: appStore.isDarkMode ? context.cardColor : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                ),
                child: FaIcon(
                  wishListStore.isItemInWishlist(proDetail!.id!) ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  size: 14,
                  color: context.iconColor,
                ),
              ).onTap(() {
                addItemToWishlist(proDetail!);
              }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
            )
          ],
        );
      },
    );
  }
}
