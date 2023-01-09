import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/discoutTag.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/cart/CartModel.dart';
import 'package:pet_shop_flutter/screens/productByCategory/components/PriceWidget.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class CartItemWidget extends StatelessWidget {
  final CartData cartData;

  CartItemWidget({required this.cartData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4)), borderRadius: radius()),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonCacheImage(
                    cartData.thumbnail.validate(),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRect(defaultRadius).paddingAll(8),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(cartData.name.validate(), style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis).expand(),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                            child: FaIcon(FontAwesomeIcons.trashAlt, size: 14, color: primaryColor),
                          ).onTap(() {
                            removeCartItemDialog(context, cartData);
                          }, borderRadius: BorderRadius.circular(defaultRadius), highlightColor: primaryColor.withOpacity(0.3)),
                        ],
                      ),
                      2.height,
                      if (cartData.sku != null) Text(cartData.sku.validate(), style: secondaryTextStyle(size: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                      if (cartData.stock_status.validate().isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(16)),
                          child: Text(cartData.stock_status.validate(), style: secondaryTextStyle(color: Colors.white, size: 12)),
                        ),
                      4.height,
                      PriceWidget(regularPrice: cartData.regular_price, salePrice: cartData.sale_price),
                      8.height,
                      if (cartData.ps_product_type != ProductTypePet)
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4)), borderRadius: BorderRadius.circular(defaultRadius)),
                          child: Row(
                            children: [
                              Icon(Icons.remove, size: 18).paddingSymmetric(horizontal: 8, vertical: 8).onTap(() {
                                int qty = cartData.quantity.validate(value: "1").toInt();

                                if (qty > 1) {
                                  cartData.quantity = (qty - 1).toString();

                                  cartStore.updateCartItem(cartData);
                                } else {
                                  cartData.quantity = '1';
                                }
                                cartStore.calculateTotals();
                              }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
                              Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.4)),
                              Text('${cartData.quantity.validate(value: "1")}', style: primaryTextStyle()).paddingSymmetric(horizontal: 12),
                              Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.4)),
                              Icon(Icons.add, size: 18).paddingSymmetric(horizontal: 8).onTap(() {
                                int qty = cartData.quantity.validate(value: "1").toInt();
                                cartData.quantity = (qty + 1).toString();

                                cartStore.updateCartItem(cartData);
                              }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
                            ],
                          ),
                        ).fit()
                    ],
                  ).paddingAll(8).expand()
                ],
              ),
            ],
          ),
          if (cartData.sale_price!.isNotEmpty)
            Positioned(
              left: 0,
              top: 20,
              child: DiscountTag(
                discount: discountText(cartData.regular_price!, cartData.sale_price!),
              ),
            ),
        ],
      ),
    );
  }

  removeCartItemDialog(BuildContext context, CartData data) {
    return showConfirmDialogCustom(
      context,
      primaryColor: primaryColor,
      title: language!.removeItem,
      positiveText: language!.yes,
      negativeText: language!.cancel,
      onAccept: (c) {
        cartStore.addToCart(data);
        finish(context);
      },
    );
  }
}
