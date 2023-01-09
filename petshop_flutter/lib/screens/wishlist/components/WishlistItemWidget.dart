import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/discoutTag.dart';
import 'package:pet_shop_flutter/model/cart/CartModel.dart';
import 'package:pet_shop_flutter/model/wishlist/WishListModel.dart';
import 'package:pet_shop_flutter/screens/productByCategory/components/PriceWidget.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

import '../../../main.dart';

class WishlistItemWidget extends StatelessWidget {
  final WishListModel data;

  WishlistItemWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: (context.width() / 2) - 12,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonCacheImage(data.thumbnail.validate(), width: context.width(), height: 180, fit: BoxFit.cover)
                  .cornerRadiusWithClipRRectOnly(topRight: defaultRadius.toInt(), topLeft: defaultRadius.toInt()),
              8.height,
              Text(data.name.validate(), style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis).paddingOnly(left: 12, right: 8),
              4.height,
              PriceWidget(salePrice: data.sale_price.validate(), regularPrice: data.regular_price.validate()).paddingOnly(left: 12, right: 8, bottom: 8),
              Divider(height: 0),
              SizedBox.fromSize(
                size: Size(context.width(), 40),
                child: Text(language!.moveToCart, style: boldTextStyle()).center(),
              ).onTap(() {
                if (cartStore.cartList.any((element) => element.pro_id == data.pro_id)) {
                  snack(language!.itemAlreadyInCart);
                  wishListStore.addToWishList(data);
                } else {
                  addItemToCart(data);
                }
              }, splashColor: Colors.transparent, highlightColor: Colors.transparent),
            ],
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(shape: BoxShape.circle, color: appStore.isDarkMode ? context.cardColor : Colors.white.withOpacity(0.5), border: Border.all(color: Colors.grey.shade300)),
            child: Icon(Icons.close, size: 16, color: context.iconColor),
          ).onTap(() async {
            await showConfirmDialogCustom(
              context,
              primaryColor: primaryColor,
              title: language!.removeItem,
              positiveText: language!.yes,
              negativeText: language!.cancel,
              onAccept: (c) async {
                appStore.setLoading(true);
                await wishListStore.addToWishList(data);
                appStore.setLoading(false);
              },
            );
          }),
        ),
        if (data.sale_price!.isNotEmpty)
          Positioned(
            left: 0,
            top: 20,
            child: DiscountTag(
              discount: discountText(data.regular_price!, data.sale_price!),
            ),
          ),
      ],
    );
  }

  addItemToCart(WishListModel data) async {
    CartData cartData = CartData();

    cartData.pro_id = data.pro_id;
    cartData.name = data.name;
    cartData.thumbnail = data.thumbnail;
    cartData.sale_price = data.sale_price;
    cartData.regular_price = data.regular_price;
    cartData.sku = data.sku;
    cartData.ps_product_type = data.ps_product_type;

    await cartStore.addToCart(cartData);

    wishListStore.addToWishList(data);
  }
}
