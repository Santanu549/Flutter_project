import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/screens/CheckOutSummaryScreen.dart';
import 'package:pet_shop_flutter/screens/auth/SignInScreen.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class CartAmountDetailSheet extends StatefulWidget {
  @override
  CartAmountDetailSheetState createState() => CartAmountDetailSheetState();
}

class CartAmountDetailSheetState extends State<CartAmountDetailSheet> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      color: context.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language!.orders, style: boldTextStyle(size: 20)).paddingAll(16),
          Divider(height: 0),
          8.height,
          orderData(title: language!.totalAmount, subtitle: '\$ ${cartStore.cartTotalAmount}'),
          orderData(title: language!.youSaved, subtitle: '- \$ ${cartStore.cartSavedAmount}', color: Colors.red),
          Divider(indent: context.width() * 0.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language!.payableAmount, style: boldTextStyle(size: 24)),
              Text('\$ ${cartStore.cartTotalPayableAmount}', style: boldTextStyle(size: 26)),
            ],
          ).paddingAll(16),
          AppButton(
            width: context.width(),
            text: language!.proceedCheckout,
            textStyle: boldTextStyle(color: Colors.white),
            onTap: () {
              //
              Navigator.pop(context);
              if (appStore.isLoggedIn) {
                if (appStore.billingAddress!.first_name!.isNotEmpty) {
                  CheckOutSummaryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                } else {
                  toast("Please Add Address");
                }
              } else {
                SignInScreen().launch(context);
              }
            },
          ).paddingOnly(left: 16, right: 16, bottom: 16)
        ],
      ),
    ).fit();
  }
}
